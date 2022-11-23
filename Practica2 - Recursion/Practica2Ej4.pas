{4.- Escribir un programa que:
a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.}

program Recursivo;
const
  dimf=20;
type
   vector=array[1..dimf] of integer;
 
 procedure  CargarVector(var v:vector; diml:integer);
 var 
	num: integer;
 begin
	Randomize;
    num := random (101);
	if (diml <> dimf) then begin
	CargarVector(v,diml+1);
	v[diml]:=num;	
	end;
end;

procedure Imprimir (v:vector);
var
 i:integer;
 begin
   for i:=1 to dimf do
       writeln(v[i]);
 end;
 
 procedure ImprimirMaximo (v:vector;var max:integer; diml:integer);
 begin
     if (diml<>dimf) then begin
           if (v[diml] > max) then 
                 max:=v[diml];
           ImprimirMaximo (v,max, diml+1);
      end;
end;   

 procedure SumaElementos (v:vector;var suma:integer; diml:integer);
 begin
     if (diml<>dimf) then begin
           suma:= suma + v[diml];
           SumaElementos (v,suma, diml+1);
      end;
end;   

var
  v:vector;
  diml,max, suma:integer;
begin
  diml:=0;
  CargarVector(v,diml);
  Imprimir(v);
  max:=-1;
  ImprimirMaximo(v,max,diml);
  writeln('El numero maximo es: ', max);
  suma:=0;
  SumaElementos(v, suma, diml);
  writeln('La suma es: ', suma);
end.
