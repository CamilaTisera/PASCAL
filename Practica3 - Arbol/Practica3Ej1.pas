{1.	Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol binario de búsqueda. 
De cada socio se lee número de socio, nombre y edad. La lectura finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que : 
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socio se encuentra entre los dos valores ingresados. 
Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantidad.
x. Informe los números de socio en orden creciente. 
xi. Informe los números de socio pares en orden decreciente. }

program Arbol;
type
  socio=record
    num:integer;
    nombre:string[20];
    edad:integer;
  end;
  
  abb=^nodo;
  
  nodo=record
     dato:socio;
     HI:abb;
     HD:abb;
  end;

procedure CargarArbol (var a:abb);

procedure LeerDatos (var s:socio);
begin
   writeln('Ingrese numero de socio');
   readln(s.num);
   if(s.num <> 0) then begin
     writeln('Ingrese nombre');
     readln(s.nombre);
     writeln('Ingrese edad');
     readln(s.edad);
   end;
end;

procedure InsertarArbol (var a:abb; s:socio);
begin
  if(a=nil) then begin
     new(a);
     a^.dato:=s;
     a^.HI:=nil;
     a^.HD:=nil;
  end
  else
     if (a^.dato.num >= s.num) then
        InsertarArbol(a^.HI, s)
     else
         if (a^.dato.num <= s.num) then
             InsertarArbol(a^.HD, s);
end;

var
   s:socio;
 begin
    LeerDatos(s);
    while(s.num <> 0) do begin
       InsertarArbol(a, s);
        LeerDatos(s);
    end;
 end;
 
 procedure Imprimir (a:abb);
begin
   if (a<>nil) then begin
       Imprimir(a^.HI);
       Imprimir(a^.HD);
       writeln(a^.dato.num);
   end;
end;
 
function Maximo (a:abb) : integer;
 begin
     if (a^.HD<>nil) then 
             Maximo:=Maximo(a^.HD)
     else
       Maximo:=a^.dato.num
end;   

procedure Minimo (a:abb; var min, edadMin:integer; var nomMin:string);
 begin
     if (a^.HI<>nil) then
                Minimo (a^.HI,min, edadMin, nomMin)
     else
        if (a^.dato.num < min) then begin
                 min:=a^.dato.num;
                 nomMin:=a^.dato.nombre;
                 edadMin:=a^.dato.edad;
      end;
end;   

function MaximoEdad (a:abb; max:integer) : integer;  //Esta ordenado por numero de socio
 begin
     if (a<>nil) then begin
             if(max <a^.dato.edad) then
                MaximoEdad:= a^.dato.edad
     else
       MaximoEdad(a^.HI, max);
        MaximoEdad(a^.HD, max);
     end;
end;   

procedure AumentarEdad (a: abb);
begin
 if (a <> nil) then begin
        a^.dato.edad:= a^.dato.edad + 1;
        AumentarEdad (a^.HI);
        AumentarEdad (a^.HD);
      end;
end;

function Buscar (a:abb; valor:integer) : boolean;
 begin
     if (a=nil) then 
             Buscar:=false
     else
      if(valor = a^.dato.num) then
         Buscar:=true
      else
        if (a^.dato.num > valor)  then
             Buscar:= Buscar(a^.HI, valor)
         else
               Buscar:= Buscar(a^.HD, valor)              
end;   

function BuscarNombre (a:abb; nombre:string) : boolean;
 begin
     if (a=nil) then 
             BuscarNombre:=false
     else
        if (nombre = a^.dato.nombre) then
           BuscarNombre:=true
         else begin
            BuscarNombre:= BuscarNombre(a^.HI,nombre);      
            if (BuscarNombre = false) then
                BuscarNombre:= BuscarNombre(a^.HD,nombre);   
          end;
end;
  

function CantidadSocios(a:abb):integer;
begin
  if(a=nil)then
    CantidadSocios:=0
  else
    CantidadSocios:=1+CantidadSocios(a^.HI)+CantidadSocios(a^.HD);
end;

function Promedio (a: abb):real;

function SumaEdad(a:abb):integer;
begin
  if(a=nil)then   //Sacar y buscar la form de eficientizarlo
    SumaEdad:=0
  else
    SumaEdad:=a^.dato.edad+SumaEdad(a^.HI)+SumaEdad(a^.HD);
end;

begin
    Promedio:= SumaEdad(a) / CantidadSocios(a);
end;


procedure  Buscar (a:abb;valor1,valor2:integer; var cant:integer);  //Probar con funcion
begin
    if(a<>nil)then begin
        if(a^.dato.num>=valor1) and (a^.dato.num<=valor2) then begin
            cant:=cant + 1;
             Buscar(a^.HI,valor1,valor2, cant);
             Buscar(a^.HD,valor1,valor2, cant);
        end
        else
          if(a^.dato.num< valor1) then
              Buscar(a^.HD,valor1,valor2, cant)
          else
            Buscar(a^.HI,valor1,valor2, cant);
  end;
  end;

procedure enordenCreciente (a:abb);
begin
      if (a <> nil) then begin
            enordenCreciente(a^.HI);
            writeln(a^.dato.num);   {imprime de mayor a menor los datos}
            enordenCreciente(a^.HD);
            end;
end;  
  
procedure enordenDecreciente (a:abb); 
begin
      if (a <> nil) then begin
        if(a^.dato.num mod 2 = 0) then
            writeln(a^.dato.num);   {imprime de menor a mayor los datos}
        enordenDecreciente(a^.HI);
        enordenDecreciente(a^.HD);
           end;
end;  

 var
   a:abb;
   min,edad, valor:integer;
 valor1, valor2, cant, max:integer;
   nom:string;
 begin
    a:=nil;
    min:=9999;
    cant:=0;
    max:=-1;
   CargarArbol(a);
   if (a = nil ) then
      writeln('El arbol esta vacio')
    else begin
        writeln('Imprimir arbol');
         Imprimir(a);
         writeln;
        writeln('El numero de socio mas grande es: ', Maximo(a));
        Minimo(a, min, edad, nom);
        writeln;
        writeln('El codigo de socio minimo es: ',  min , ' su nombre es '  ,  nom ,  ' su edad es:  ' ,  edad);
        writeln;
        writeln('La edad mas grande es: ', MaximoEdad(a, max));
		AumentarEdad(a);
          writeln('Ingrese un valor');
          readln(valor);
          writeln;
          writeln('El valor buscado es: ', Buscar(a,valor));
           writeln('Ingrese un nombre');
          readln(nom);
          writeln;
          writeln('El nombre buscado es: ', BuscarNombre(a,nom));
          writeln;
         writeln;
          writeln('La cantidad de socios es: ',CantidadSocios(a));
          writeln;
          writeln('El promedio es: ',Promedio(a):2:2);
          writeln;
		writeln('Estamos en el Rango');
		writeln('Ingrese valor 1 y valor 2');
		readln(valor1);
		readln(valor2);
		Buscar(a,valor1,valor2,cant);
          writeln('La cantidad de socios en ese rango de valores es:' ,cant);
          writeln;
          writeln('En orden creciente');
          enordenCreciente(a);
          writeln;
          writeln('En orden decreciente');
          enordenDecreciente(a);
    end;
 end.
