map = %Q{
  function() {
    ano = this.data_disponibilizacao.getFullYear();
    emit({concedente:this.orgao_superior, ano:ano}, 1);
  }
}

reduce = %Q{
  function (key, values) {
    var sum = 0;
    values.forEach(function (v) {
      sum += v;
    });
    
    return sum;
  }
}

ProgramaOrgaoStat.delete_all
collection = Programa.collection.map_reduce(map, reduce, :out => 'mr_programa_orgao_stat')
documents = collection.find.map do |c| {:concedente => c['_id']['concedente'], :ano => c['_id']['ano'], :total => c['value']} end
collection.drop

while !documents.empty? do
  data = documents.slice! 0, BUCKET_SIZE
  ProgramaOrgaoStat.collection.insert data
end

documents = nil
GC.start
