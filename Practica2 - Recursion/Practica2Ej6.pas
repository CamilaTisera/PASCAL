{6.- Realizar un programa que lea números y que utilice un procedimiento recursivo que escriba el equivalente en binario de un número decimal.
 El programa termina cuando el usuario ingresa el número 0 (cero). 

Ayuda:  Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2. ¿Cómo obtenemos los dígitos que componen al número? 
¿Cómo achicamos el número para la próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.}

program Binario;


procedure Digitos(num:integer);
var 
  dig: integer;
Begin
  if (num <> 0)   then begin
        dig:= num mod 2;
        num:= num div 2;
        if (dig = 0) then begin
          Digitos(num);
           writeln(0);
        end
        else begin
           Digitos(num);
           writeln(1);
         end;
  end;
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
