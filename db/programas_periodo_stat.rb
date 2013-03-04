map = %Q{
  function() {
    ano = this.data_disponibilizacao.getFullYear();
    mes = this.data_disponibilizacao.getMonth() + 1;
    emit({ano: ano, mes: mes}, 1);
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

ProgramaPeriodoStat.delete_all
collection = Programa.collection.map_reduce(map, reduce, :out => 'mr_programa_periodo_stat')
documents = collection.find.map do |c| {:ano => c['_id']['ano'], :mes => c['_id']['mes'], :total => c['value']} end
collection.drop

ProgramaPeriodoStat.collection.insert documents
documents = nil
GC.start
