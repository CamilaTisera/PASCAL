{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. }
//Agregar funciones

program Recursividad;
type
    lista=^nodo;
    
    nodo=record
       dato:integer;
       sig:lista;
    end;
    
//Inciso A

procedure AgregarAdelante(var L:lista; num: integer);
Var 
 nue:Lista;
Begin
 New(nue);
 nue^.dato:=num;
 nue^.sig:=L;
 L:=nue;
End;

 procedure  CargarLista (var L:lista);
 var
   num:integer;
 begin
    num := random (100);
	if (num <> 0) then 
	begin
	CargarLista ( L);
	AgregarAdelante(L,num);	
	end;
end;

procedure ImprimirListaMismoOrden (l: lista);
begin
  if (l<> nil) then begin
                      writeln (' ', l^.dato);
                      ImprimirListaMismoOrden (l^.sig);
                    end;
end;

//Inciso B

procedure ImprimirMinimo (L:lista;var min:integer);
 begin
     if (L<>nil) then begin
           if (L^.dato < min) then
                 min:=L^.dato;
           ImprimirMinimo (L^.sig,min);
      end;
end;   
//Inciso C

procedure ImprimirMaximo (L:lista;var max:integer);
 begin
     if (L<>nil) then begin
           if (L^.dato > max) then 
                 max:=L^.dato;
           ImprimirMaximo (L^.sig,max);
      end;
end;   

{function Maximo(l: lista; x:integer):boolean;  //Completar
begin
  if(l=nil) then
     Maximo:=false
   else
     if(l^.dato = x) then
       Maximo:=true
     else
         Maximo:= (x = l^.dato) or (Maximo(l^.sig,x))
end;

function MaxLista (l:lista): integer;
 begin
     if (l=nil) then
         MaxLista:=-1
     else
        MaxLista:=Maximo(l^.dato, ImprimirMaximo(l^.sig));      //Crear funciona Maximo
end; }

procedure Buscar(L:lista;num:integer;var exito:boolean);
begin
   if L=nil then
      exito:=false
   else
        if L^.dato = num then
            exito:=true
         else
             Buscar (L^.sig,num,exito);
End;

var
  l:lista;
  min, max, num:integer;
  exito:boolean;
begin
    l:=nil;
    Randomize;
   CargarLista(l);
   write('Imprimir lista');
   if (L = nil) then 
	     writeln ('--- Lista sin elementos ---')
   else begin
        writeln ('--- Lista obtenida --->');
       ImprimirListaMismoOrden(l);
     end;
   min:=9999;
   ImprimirMinimo(l, min);
   writeln('El valor minimo es: ', min);
    max:=-1;
    ImprimirMaximo(l, max);
    writeln('El valor maximo es: ', max);
    exito:=false;
    writeln('Ingrese un numero');
    readln(num);
    Buscar(l, num, exito);
    writeln(exito);
end.
