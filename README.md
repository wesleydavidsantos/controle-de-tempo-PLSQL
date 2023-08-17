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





SET SERVEROUTPUT ON;

DECLARE
-- Teste Package CONTROLE_TEMPO
-- Autor: Wesley David Santos
-- Skype: wesleydavidsantos		
-- https://www.linkedin.com/in/wesleydavidsantos
--

	v_ID_CRONOMETRO_01 VARCHAR2(100);
	v_ID_CRONOMETRO_02 VARCHAR2(100);
	
	v_CONTADOR_LOOP_01 NUMBER DEFAULT 0;
	v_CONTADOR_LOOP_02 NUMBER DEFAULT 0;
	
BEGIN

	v_ID_CRONOMETRO_01 := CONTROLE_TEMPO.SET_TEMPO_LIMITE(10);
	
	v_ID_CRONOMETRO_02 := CONTROLE_TEMPO.SET_TEMPO_LIMITE(5);
	
	LOOP
		
		IF CONTROLE_TEMPO.VERIFICAR_TEMPO( v_ID_CRONOMETRO_01 ) THEN
			
			DBMS_OUTPUT.PUT_LINE( 'Loop 01 - Execuções: ' || v_CONTADOR_LOOP_01 || ' / Horário: ' || SYSDATE  );
			DBMS_OUTPUT.PUT_LINE( '' );
			
			EXIT;
		
		END IF;
		
		
		v_CONTADOR_LOOP_01 := v_CONTADOR_LOOP_01 + 1;
		
		
		LOOP
			
			IF CONTROLE_TEMPO.VERIFICAR_TEMPO( v_ID_CRONOMETRO_02 ) THEN
			
				DBMS_OUTPUT.PUT_LINE( 'Loop 02 - Execuções: ' || v_CONTADOR_LOOP_02 || ' / Horário: ' || SYSDATE );
				DBMS_OUTPUT.PUT_LINE( '' );
				
				EXIT;
				
			END IF;
			
			v_CONTADOR_LOOP_02 := v_CONTADOR_LOOP_02 + 1;
								
		END LOOP;
		
		
	END LOOP;
	
END;
/
