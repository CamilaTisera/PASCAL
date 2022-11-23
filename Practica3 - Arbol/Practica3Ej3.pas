{3.	Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de datos sólo a aquellos alumnos que posean año de ingreso posterior al 2010. 
De cada alumno se lee legajo, DNI y año de ingreso. La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro. 
c. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.}

program Alumnos;
type

	alumno=record
	  legajo:integer;
	  dni:integer;
	  anio:integer;
	end;
	
	abb=^nodo;
	
	nodo=record
	  dato:alumno;
	  HI:abb;
	  HD:abb;
end;

procedure cargarArbol (var a:abb);

procedure leerDatos (var a:alumno);
begin
   writeln('Ingrese año');
   readln(a.anio);
   if(a.anio > 2010) then begin
    writeln('Ingrese legajo');
   readln(a.legajo);
   writeln('Ingrese dni');
   readln(a.dni);
   end;
end;

procedure InsertarArbol (var a:abb; al:alumno);
begin
  if (a=nil) then begin
    new(a);
    a^.dato:=al;
    a^.HI:=nil;
    a^.HD:=nil;
  end
  else
    if(a^.dato.legajo > al.legajo) then
       InsertarArbol(a^.HI, al)
    else
         InsertarArbol(a^.HD, al)
end;

var
  al:alumno;
begin
  leerDatos(al);
  while(al.anio > 2010) do begin
    InsertarArbol(a,al);
    leerDatos(al);
  end;
end;


procedure buscarLegajo (a:abb; valor:integer); //¿Que pasa si no hay legajos en el valor ingresado?
 begin
     if(a<>nil)then begin
        if(a^.dato.legajo<valor) then begin
          writeln('El dni del alumno es: ', a^.dato.dni);
          writeln('El anio del alumno es: ', a^.dato.anio);
      end;
              buscarLegajo(a^.HI,valor);
             buscarLegajo(a^.HD,valor);
       end   
end;   

procedure buscarLegajoA (a:abb;valor1, valor2:integer); //¿Que pasa si no hay legajos en el valor ingresado?
 begin
     if(a<>nil)then begin
         if(a^.dato.legajo>valor1) then begin
         if(a^.dato.legajo<valor2) then begin
            writeln('El dni del alumno es: ', a^.dato.dni);
            writeln('El anio del alumno es: ', a^.dato.anio);
      end;
            buscarLegajoA(a^.HI,valor1,valor2);
             buscarLegajoA(a^.HD,valor1,valor2);
         end
       else begin
              buscarLegajoA(a^.HD,valor1,valor2);
             buscarLegajoA(a^.HI,valor1,valor2);
             end;
       end   
end; 

function MaximoDNI (a:abb; max:integer) : integer; //Esta ordenado por legajo y pide el dni mas grande
 begin
     if (a<>nil) then begin
             if(max <a^.dato.dni) then
                MaximoDNI:= a^.dato.dni
     else
       MaximoDNI(a^.HI, max);
        MaximoDNI(a^.HD, max);
     end;
end;   

procedure Impar (a:abb; var cant:integer);
 begin
     if (a<>nil) then begin
       if(a^.dato.legajo mod 2 <> 0) then begin
            cant := cant + 1;
            Impar(a^.Hi,cant);
            Impar(a^.HD,cant);
          end
        else  begin
            Impar(a^.HD,cant);
            Impar(a^.HI,cant);
          end;
      end;
end;   

var
  a:abb;
  valor, valor1,valor2, cant, max:integer;
begin
  cant:=0;
  max:=-1;
  cargarArbol(a);
  if(a=nil) then
    writeln('El arbol esta vacio')
 else begin
    writeln('Ingrese un valor');
    readln(valor);
    writeln('Legajos comprendidos en un valor');
    writeln;
    buscarLegajo(a, valor);
    writeln;
    writeln;
    writeln('Legajos comprendidos en dos valores');
    writeln;
    writeln('Ingrese un valor1');
    readln(valor1);
    writeln('Ingrese un valor2');
    readln(valor2);
    buscarLegajoA(a,valor1,valor2);
    writeln;
    writeln;
    writeln('El dni mas grande es: ' , MaximoDNI(a, max));
    writeln;
    writeln;
     Impar(a, cant);
    writeln('La cantidad de legajos impares es: ' ,cant);
 end;
end.
