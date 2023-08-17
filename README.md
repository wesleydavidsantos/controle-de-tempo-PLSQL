# controle-de-tempo-PLSQL

Você que é Desenvolvedor PL/SQL, então esse meu código pode te ajudar muito.

Essa package permite controlar o tempo para execução de processos, principal uso dentro de Loop.

Com certeza você já teve aquele processo demorado de Carga ETL que fica executando por vários minutos ou talvez horas onde a carga está dentro de um Loop ou Cursor.

O problema desses processos de ETL é como identificar em intervalos de tempo como está o processo de carga, por causa disso eu criei uma Package de Controle de Tempo,
desta forma você consegue definir um intervalo de tempo específico para registrar um Log sem comprometer a performance de execução do ETL.


Segue abaixo um teste demonstrando a execução, neste teste criei dois Loop, um dentro do outro, o primeiro loop deve finalizar depois de 10 segundos e o segundo loop após 5 segundos,
nesse teste o primeiro loop executa apenas duas vezes enquanto o Loop 02 executa centenas de milhares de vezes.

Dentro do seu processo de ETL você pode cronometrar que a cada 10 minutos um log é gerado em uma tabela, desta forma você acompanha o ETL sem comprometer a performance de execução. 

Resultado do Teste:

Loop 02 - Execuções: 490153 / Horário: 2023-08-17 09:07:48

Loop 02 - Execuções: 455990 / Horário: 2023-08-17 09:07:53

Loop 01 - Execuções: 2 / Horário: 2023-08-17 09:07:53
