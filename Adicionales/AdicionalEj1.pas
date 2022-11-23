{1.- El administrador de un edificio de oficinas, cuenta en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa que:
a)	Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa código de identificación, DNI del propietario y valor de la expensa. 
La lectura finaliza cuando llega el código de identificación -1.
b)	Ordene el vector, aplicando uno de los métodos de inserción vistos en la cursada, para obtener el vector ordenado por código de identificación de la oficina.
c)	Realice una búsqueda dicotómica que recibe el vector generado en b) y un código de identificación de oficina y retorne si dicho código está en el vector. 
En el caso de encontrarlo, se debe informar el DNI del propietario y en caso contrario informar que el código buscado no existe.
d)	Tenga un módulo recursivo que retorne el monto total de las expensas.}

program Administrador;
const
  dimf=300;
type
 oficinas=1..dimf;
 
 oficina=record
   cod:integer;
   dni:integer;
   valor:real;
 end;
 
 vector=array [oficinas] of oficina;
 
 {a)	Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa código de identificación, DNI del propietario y valor de la expensa. 
La lectura finaliza cuando llega el código de identificación -1.}

procedure cargarVector (var v:vector; var diml:integer);

procedure leerDatos (var o:oficina);
begin
 writeln('Ingrese codigo de identificacion');
 readln(o.cod);
 if(o.cod<>-1) then begin
  writeln('Ingrese dni');
 readln(o.dni);
  writeln('Ingrese valor');
 readln(o.valor);
 end;
end;

var
 o:oficina;
 begin
 leerDatos(o);
    while (diml<dimf) and (o.cod <> -1) do begin
       diml:=diml+1;
       v[diml]:=o;
       leerDatos(o);
    end; 
 end;
 
 {b)	Ordene el vector, aplicando uno de los métodos de inserción vistos en la cursada, para obtener el vector ordenado por código de identificación de la oficina.}
 
 procedure OrdenarPorSeleccion(var v:vector; var diml:integer);
 var
  i,j,pos:integer;
   o:oficina;
 begin
    for i:=1 to diml-1 do begin
      pos:=i;
      for j:=i+1 to diml do
       if (v[j].cod<v[pos].cod) then
          pos:=j;
      o:=v[pos];
      v[pos]:=v[i];
      v[i]:=o;
       end;
 end;
 
 {c)	Realice una búsqueda dicotómica que recibe el vector generado en b) y un código de identificación de oficina y retorne si dicho código está en el vector.
 * En el caso de encontrarlo, se debe informar el DNI del propietario y en caso contrario informar que el código buscado no existe.}
 
procedure busquedaDicotomica(v:vector;ini,diml,codigo:integer;var pos:integer);
var
    medio:integer;
begin
   if (ini>diml) then
      pos:=0
   else begin
      medio:=(ini+diml)div 2;
      if(v[medio].cod= codigo)then
         pos:=medio
      else
         if (codigo < v[medio].cod)then
            busquedaDicotomica(v,ini,medio-1,codigo, pos)
         else
            busquedadicotomica(v,medio+1,diml,codigo, pos);
      end;
end;

{d)	Tenga un módulo recursivo que retorne el monto total de las expensas.}

procedure ImprimirMonto (v:vector;var suma:real;diml:integer);
 begin
     if(diml <= dimf) then begin
                 suma:=suma + v[diml].valor;
               ImprimirMonto (v,suma,diml+1);
     end;
end;   

 var
  v:vector;
  diml,ini, cod,pos,fin:integer;
  monto:real;
 begin
  diml:=0;
  ini:=0;
  monto:=0;
  fin:=diml;
   cargarVector(v,diml);
   if (diml= 0) then
     writeln('El vector esta vacio')
   else begin
   OrdenarPorSeleccion(v,diml);
   writeln('Ingrese codigo a buscar');
   readln(cod);
   busquedaDicotomica(v,ini,fin,cod,pos);
   if(pos = 0) then
     writeln('El codigo no existe')
    else
      writeln('El dni del propietario es: ' , v[pos].dni);
      diml:=1;
     ImprimirMonto(v,monto,diml);
     writeln('El monto total de las expensas es: ' ,monto:2:2);
    end;
 end.
