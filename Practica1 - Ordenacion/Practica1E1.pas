{Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades). 
El ingreso de las ventas finaliza con el código 0 (no se procesa).

a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.}

program VectorLista;
const 
	dimF = 10;   //como maximo 20 ventas
type 
	 rango1 = 0..15;   //codigo de producto
     rango2 = 1..99;   //cantidad vendida
     rango3 = 0..dimF;   //como maximo 99 unidades
     
     venta = record
				codigoP: rango1;
				cantidad: rango2;
			 end;
			 
	 vector = array [1..dimF] of venta;  //vector de venta
	 
	 lista = ^nodo;   //lista de venta
	 nodo = record
	          dato: venta;
	          sig: lista;
	        end;


//a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 


procedure AlmacenarInformacion (var v: vector; var dimL: rango3);   //Leer registro y cargar vector
  
  procedure LeerVenta (var v: venta);
  begin
    Randomize;
    write ('Codigo de producto: ');
    v.codigoP:= random(16);
    writeln (v.codigoP);
    if (v.codigoP <> 0)  then begin
           write ('Ingrese cantidad (entre 1 y 99): ');
           readln (v.cantidad);
         end;
  end;

var unaVenta: venta;
begin
    dimL := 0;
    LeerVenta (unaVenta);
    while (unaVenta.codigoP <> 0)  and ( dimL < dimF ) do 
    begin
       dimL := dimL + 1;
       v[dimL]:= unaVenta;
       LeerVenta (unaVenta);
    end;
end;

//b. Mostrar el contenido del vector resultante.

procedure ImprimirVector (v: vector; dimL: rango3);
var
   i: integer;
begin
     write ('         -');
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     write ('  Codigo:| ');
     for i:= 1 to dimL do begin
        if(v[i].codigoP <= 9)then
            write ('0');
        write(v[i].codigoP, ' | ');
     end;
     writeln;
     writeln;
     write ('Cantidad:| ');
     for i:= 1 to dimL do begin
        if (v[i].cantidad <= 9)then
            write ('0');
        write(v[i].cantidad, ' | ');
     end;
     writeln;
     write ('         -');
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     writeln;
End;

//c. Ordenar el vector de ventas por código.

procedure OrdenarSeleccion (var v: vector; dimL: rango3);
var 
  i, j, pos: rango3; 
  item: venta;	
begin
 for i:= 1 to dimL - 1 do 
 begin {busca el mínimo y guarda en pos la posición}
   pos := i;
   for j := i+1 to dimL do 
        if (v[j].codigoP < v[pos].codigoP) then pos:=j;

   {intercambia v[i] y v[pos]}
   item := v[pos];   
   v[pos] := v[i];   
   v[i] := item;
 end;
end;

//e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 


procedure Eliminar (var v: vector; var dimL: rango3; valorInferior, valorSuperior: rango1);

  function BuscarPosicion (v: vector; dimL: rango3; posInferior: rango1): rango3;
  var 
	pos: rango3;
  begin
    pos:= 1;
    while (pos <= dimL) and (posInferior > v[pos].codigoP) do
       pos:= pos + 1;
    if (pos > dimL) then 
      BuscarPosicion:= 0
    else 
       BuscarPosicion:= pos;
  end;
  
  function BuscarPosicionDesde (v: vector; dimL, pos : integer; posSuperior: rango1): rango3;
  begin
    while (pos <= dimL) and (posSuperior >= v[pos].codigoP) do
       pos:= pos + 1;
    if (pos > dimL) then 
        BuscarPosicionDesde:= dimL
     else 
         BuscarPosicionDesde:= pos - 1;
  end;

var 
  posInferior, posSuperior, salto, i: rango3; 
Begin
  posInferior:= BuscarPosicion (v, dimL, valorInferior); //Posicion Inicial
  if (posInferior <> 0) then begin
         posSuperior:= BuscarPosicionDesde (v, dimL, posInferior, valorSuperior);   //Posicion superior
                  {Escribir el código correspondiente para hacer el corrimiento y disminuir la dimensión lógica}
          salto:= posSuperior - posInferior ;
      end;
         for i:= 1+posSuperior to diml do 
                v[i - salto] := v[i];        //Borra i  - salto y volve a la posicion i
            diml:=diml -  salto;       //Disminuyo la dimencion logica
 end;
 
 //g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
 
 procedure GenerarLista (v: vector; dimL: rango3; var L: lista);
        
procedure AgregarAtras (var L,ult: lista; elem: venta);
 var 
     nue : lista;
  begin
       new (nue);
       nue^.dato:= elem;
       nue^.sig := NIL;
       
      if ( L<> Nil) then
            ult^.sig := nue
       else
             L:= nue;
       ult := nue;
       end;
  
 function Cumple (cod: rango1): boolean;
   begin
       if ((cod mod 2 ) = 0) then
          Cumple:=true
       else
          Cumple:=false;
   end;
   
var
  i: rango3; 
  ult:lista;
begin
  ult:= nil;
  for i:= dimL downto 1 do begin
    if Cumple (v[i].codigoP) then 
        AgregarAtras (L,ult, v[i]);
end; 
end;

procedure ImprimirLista (L: lista);
begin
 	while(L<>nil) do begin
    writeln('Los numeros de la lista son: ', L^.dato.codigoP);
    writeln('Los numeros de la lista son: ', L^.dato.cantidad);
    L:=L^.sig;
    end;
end;

var 
    v: vector;
    dimL: rango3;
    valorInferior, valorSuperior: rango1;
    L:lista;
Begin
   L:= nil;
  AlmacenarInformacion (v, dimL);
  writeln;
  OrdenarSeleccion(v,dimL);
  ImprimirVector(v,dimL);
  if (dimL = 0) then 
	writeln ('--- Vector sin elementos ---')
   else begin
	writeln ('--- Vector ingresado --->');
	writeln;
	ImprimirVector (v, dimL);
	writeln;
	writeln ('--- Vector ordenado --->');
	writeln;
	OrdenarSeleccion (v, dimL);
	ImprimirVector (v, dimL);
    writeln('ingrese valor inferior');
	readln(valorInferior);
	writeln('Ingrese valor superior');
	readln(valorSuperior);
   Eliminar (v,dimL,valorInferior, valorSuperior);
   ImprimirVector(v,dimL);
  if (dimL = 0) then 
		writeln ('--- Vector sin elementos, luego de la eliminacion ---')
   else begin
		writeln;
        writeln ('--- Vector luego de la eliminacion --->');
		writeln;
		ImprimirVector (v, dimL);
	    GenerarLista (v, dimL, L);
	    if (L = nil) then 
	      writeln ('--- Lista sin elementos ---')
        else begin
             writeln;
             writeln ('--- Lista obtenida --->');
              writeln;
             ImprimirLista (L);
        end;
      end;
end;
end.
