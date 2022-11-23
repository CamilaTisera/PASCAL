{2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número leído, sus dígitos en el orden en que aparecen en el número. 
Debe implementarse un módulo recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe imprimir 2  5  6}

program e2;

procedure Digitos(num:integer);
var 
  dig: integer;
Begin
  if (num <> 0)   then begin
        dig:= num mod 10;
        num:= num div 10;
       Digitos(num);
       writeln(dig);
  end
End;

//pp
var num: integer;
begin
  write('Ingrese numero: ');
  read(num);
  while (num <> 0) do begin
      Digitos(num);
      write('Ingrese numero');
      read(num);
   end;
end.
