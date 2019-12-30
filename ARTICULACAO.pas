Program AlgoritmoemGrafos;
uses crt, dos;

var
MAdjacencia : Array [1..100,1..100] of integer; {Matriz de Adjacencia do Grafo}
n,m         : Integer;      {Quantidade de Vertices e de Arestas direcionadas do Grafo}
arquivo     : Text;         {Arquivo texto onde esta o Grafo}
arqok       : Boolean;      {Arquivo encontrado ou nao}
nomearquivo : String;       {Nome do arquivo a ser utilizado}
Auxarq      : Char;         {Auxiliar para colocar os dados do arquivo na matriz}
Snumero     : String;       {Numero do arquivo em formato String}
Inumero     : Integer;      {Numero do arquivo em formato inteiro}
I, J, i1, j1: Integer;      {Auxiliares para varrer a matriz}
erro        : Integer;      {Erro na transformacao de String para Inteiro}
Sair        : boolean;      {Sai do programa ou pede outro arquivo} 
opcao       : char;         {op‡Ço de sair ou escrever outro arquivo}

Label 123, 456;



{============ VARIAVEIS DOS ALUNOS =============}


  type MatrizAdjacencia = array[1..100,1..100] of integer;  // tipo matriz adjacencia

  function desconexo(M: MatrizAdjacencia; nVert: integer):boolean; {Função para determinar se o grafo sem um dos vértices é conexo ou não}
  var
     vetorAux: array[1..100] of integer;  // Armazena os vertices adjacentes sem ligacoes repetidas
     resultAux: boolean; 				  // Variavel de retorno da funcao
     qtdVerticesAdj: integer; 			  // Quantidade de vertices adjacentes do vetor auxiliar
     i, j, iVetAux, IndiceBusca: integer; // Indices das matrizes e vetores
     jaColocado: integer;				  // Determina se o elemento a por já existe no vetor auxliar
  begin
       qtdVerticesAdj := 0;
       resultAux := false;
       jaColocado := 0;
       ivetAux := 1;


       for i := 1 to 100 do     // preenche com zeros o vetor auxiliar
       begin
            vetorAux[i] := 0;
       end;

       for i := 1 to nVert do
       begin
            if(i = 1)then
            begin
                 inc(qtdVerticesAdj);
                 vetorAux[qtdVerticesAdj] := 1;
            end;
            for j := 1 to nVert do
            begin
                 if(i = 1)and(i <> j)and(m[i,j] = 1)then  // preenche com as ligaçoes do vertice 1
                 begin
                      inc(qtdVerticesAdj);
                      vetorAux[qtdVerticesAdj] := j;
                 end;
            end;
       end;


        while(vetorAux[iVetAux] <> 0)do  // Percorre o vetor enquanto nao chegar no fim dos vertices adjacentes quando for 0
        begin
             if(IvetAux > 1)then  // pula o primeiro vértice
             begin
                  for i := 1 to nvert do
                  begin
                       for j := 1 to nVert do
                       begin
                             jaColocado := 0;

                             if(m[i,j] = 1)and(vetorAux[iVetAux] = i)then //  direto no proximo vertice adjacente do vetor auxiliar
                             begin
                                  for IndiceBusca := 1 to qtdVerticesAdj do
                                  begin
                                       if(j = vetorAux[IndiceBusca])then   // checa se o vertice adjacente já existe no vetor Auxiliar
                                       begin
                                            inc(jaColocado);
                                       end;
                                  end;

                                  if(jaColocado = 0)then    // determina se o vertice adjacente pode ser colocado no vetor auxiliar
                                  begin
                                       inc(qtdVerticesAdj); // incrementa a quantidade de vertices adjacentes existentes no vetor auxiliar
                                       vetorAux[qtdVerticesAdj] := j;  // poe mais um vertice adjacente no vetor auxiliar
                                  end;
                             end;
                       end;
                  end;
             end;
             inc(iVetAux); // incrementa o indice do vetor auxiliar
        end;

        if(qtdVerticesAdj < nVert)then   //determina se eh conexo ou desconexo
          resultAux := true
        else
          resultAux := false;

        desconexo := resultAux;

  end;

var
   MatrizAuxiliar: array[1..100,1..100] of integer;
   vertice, contArticulacoes, Linha, Coluna: integer;
   articulacoes: array[1..100] of integer;

{======= FIM DAS VARIAVEIS DOS ALUNOS ==========}

function digrafo (nvert:integer): boolean;
begin
digrafo := false;
        for i1 := 1 to nvert do
            for j1 := 1 to nvert do
                if MAdjacencia [i1,j1] <> MAdjacencia [j1,i1] then
                digrafo := true;
end;


begin
sair := false;
while not sair do
begin
     textbackground(1);
     clrscr;
     arqok := false;
     while not arqok do         {Verificando a existencia do arquivo}
     begin
          write('Digite o nome do arquivo ou S para sair: ');
          readln (nomearquivo);
          if ((nomearquivo = 's') or (nomearquivo = 'S')) then goto 456;    
          nomearquivo := Concat (nomearquivo, '.txt');          
          if Fsearch (nomearquivo,'') <> '' then
          begin
               arqok := true;
               writeln('Arquivo localizado com sucesso!');
               readkey;
               clrscr;
          end
          else
          begin
               writeln ('Arquivo inexistente, tente novamente!')
          end;
     end;

     for i := 1 to 100 do
     for j := 1 to 100 do
     MAdjacencia [i,j] := 0;

     writeln('Trabalhos dos alunos: Icaro Vitor, Lucas Ferraz e Marcelo Carvalho');
     writeln(' ');

     writeln('Matriz de Adjacencia do Grafo no arquivo:');
     writeln(' ');

     assign (arquivo, nomearquivo);
     reset (arquivo);

     snumero := '';
     i := 1;    {Preenchimento inicial na linha  1 }
     j := 1;    {Preenchimento inicial na coluna 1 }
     m := 0;

     While not eof (arquivo) do         {Preenchimento da Matriz de Adjacencia do Grafo}
     begin

          read(arquivo, auxarq);

          if (auxarq <> ' ') and (auxarq <> chr(13)) and (auxarq <> chr(10)) then
          begin
               snumero := concat (snumero,auxarq);
          end
          else
          begin
               val (snumero,inumero,erro);

               if (erro <> 0) and (auxarq <> chr(10)) then
               begin
                    Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                    readkey;
                    goto 123;
               end;
                              
               snumero := '';
               MAdjacencia [i,j] := inumero;

               if inumero <> 0 then m := m + 1; {Definindo a quantidade de Arestas Dirigidas em digrafos}


               if auxarq = ' ' then
               begin
                    write (MAdjacencia [i,j], ' ');
                    j := j + 1;
               end
               else
               begin
                    if (auxarq <> chr(10)) then
                    begin
                         writeln (MAdjacencia [i,j], ' ');
                         i := i + 1;
                         j := 1;
                    end;
               end;
          end;          {do if}
     end;               {do while eof}


          val (snumero,inumero,erro);
          if (erro <> 0) and (auxarq <> chr(10)) then
               begin
                    Writeln('Erro: ', erro,'. Arquivo nao possui um grafo');
                    readkey;
                    goto 123;
               end;
     MAdjacencia [i,j] := inumero;
     writeln (MAdjacencia [i,j], ' ');

     m := 0;    
     n := i; 

     if digrafo (n) then
     begin
          for i1 := 1 to i do
               for j1 := 1 to i do
               begin
                       if (MAdjacencia [i1,j1] <> 0) then   
                          m := m + 1;
               end;
     end
     else
     begin
          for i1 := 1 to i do
          for j1 := 1 to i do
          begin
                  if (MAdjacencia [i1,j1] <> 0) and (i1 < j1)then
                  m := m + 1;
           end;
 
           for i1 := 1 to i do                      //Contando od la‡os
           if (MAdjacencia [i1,i1] <> 0) then
                m := m + 1;         
     end;          


    
     writeln('');
     writeln('');
     writeln('n= ',n, ' e m= ', m);

     close(arquivo);
     readkey;

{=== CODIGOS DEVEM SER IMPLEMENTADOS A PARTIR DESTA LINHA ====}

      contArticulacoes := 0;
      writeln;

      if(desconexo(mAdjacencia,n))or((n = 1)and(m = 0))then // checa se for desconexo ou trivial, nao mostra nenhuma articulacao
      begin
           writeln('Nao tem articulacao');
      end
      else
      begin
           for vertice := 1 to n do
           begin
                for Linha := 1 to n do
                begin
                     for Coluna := 1 to n do
                     begin
                          if(Linha <> vertice)and(Coluna <> vertice)then
                          begin
                               if(Linha > vertice)and(Coluna < vertice)then
                                 MatrizAuxiliar[Linha-1,Coluna] := mAdjacencia[Linha,Coluna]
                               else
                                   if(Linha < vertice)and(Coluna > vertice)then
                                        MatrizAuxiliar[Linha,Coluna-1] := mAdjacencia[Linha,Coluna]
                                   else
                                       if(Linha > vertice)and(Coluna > vertice)then
                                         MatrizAuxiliar[Linha-1,Coluna-1] := mAdjacencia[Linha,Coluna]
                                       else
                                         MatrizAuxiliar[Linha,Coluna] := mAdjacencia[Linha,Coluna];
                          end;
                     end;
                end;

                if(desconexo(MatrizAuxiliar,n-1))then   // eh testado se a matriz com o vertice removido (Matriz Auxiliar) eh desconexa
                begin
                     inc(contArticulacoes); // incrementa o contador de articulacoes
                     articulacoes[contArticulacoes] := vertice; // poe o vertice que foi removido no vetor de articulacoes
                end;
           end;
           if(contArticulacoes > 0)then
           begin
                write('Articulacoes: ');
                for i := 1 to contArticulacoes do
                begin
                     if(i < contArticulacoes)then
                       write('v',articulacoes[i],', ')
                     else
                       write('v',articulacoes[i]);
                end;
          end
          else
            writeln('Nao tem articulacao');
       end;

       writeln;
       writeln;

{=== FIM DOS CODIGOS DOS ALUNOS ====}

123:
     write ('Digite S para sair ou Enter para um novo arquivo: ');
     opcao:=ReadKey;
     opcao:=UpCase(opcao); 
     if opcao = 'S' then 
          sair := true;
end;
456:
end.
