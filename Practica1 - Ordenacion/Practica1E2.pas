{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, 
* DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program VectorOficinas;
const
   dimf=300;
 type
   rango=1..dimf;
   
   oficina=record
     cod:integer;
     dni:integer;
     valor:real;
   end;
    
    vector = array[rango] of oficina;
 
{a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, 
* DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.}
 
 procedure cargarVector (var v:vector; var diml:integer);
 
   procedure leerDatos (var o:oficina);
   begin
      write('Ingrese codigo');
      read(o.cod);
      if(o.cod<>-1) then begin
         write('Ingrese DNI');
         read(o.dni);
         write('Ingrese valor');
         read(o.valor);
      end;
   end;
   
   var
      o:oficina;
   begin
        leerDatos(o);
        while (o.cod<>-1) and (diml<dimf) do begin
            diml:=diml+1;
             v[diml]:=o;
             leerDatos(o);
          end;
   end;
   
  //Inciso B
  
  procedure OrdenarVectorPorInsercion (var v:vector; diml:integer);
var
   ofic:oficina;
   j,i:integer;
begin
    for i:=2 to diml-1 do  begin
        ofic:=v[i];
        j:=i-1;
       while (j>0) and (v[j].cod > ofic.cod) do begin
            v[j+1].cod:=v[j].cod;
            v[j+1].dni:=v[j].dni;
            v[j+1].valor:=v[j].cod;
            j:= j - 1
       end;
       v[j+1]:=ofic;
  end;   
 end;
 
 //Inciso C
 
 procedure OrdenarVectorSeleccion (var v:vector; diml:integer);
var
   ofic:oficina;
   j,i,p:integer;
begin
    for i:=1 to diml-1 do  begin
        p:=i;
        for j:= i+1 to diml do
            if v[j].cod < v[p].cod then
            p:=j;
            ofic:=v[p];
            v[p]:=v[i];
            v[i]:=ofic;
       end;
  end;   
  
  procedure ImprimirVector (v:vector; diml:integer);
var
   i:integer;
begin
     for i:=1 to diml do begin
         writeln(v[I].cod);
         writeln(v[I].dni);
         writeln(v[I].valor:2:2);
     end;
end;
  
 var
   v:vector;
   diml:integer;
 begin
   cargarVector(v,diml);
   OrdenarVectorPorInsercion(v,diml);
   write('Imprimir vector por Insercion');
   ImprimirVector(v,diml);
   write('Imprimir vector por Seleccion');
   OrdenarVectorSeleccion(v,diml);
   ImprimirVector(v,diml);
 end.
