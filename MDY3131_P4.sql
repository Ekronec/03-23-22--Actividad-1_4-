/*create or replace procedure pl(
    cadena varchar2
)
as
begin
    DBMS_OUTPUT.PUT_LINE(cadena);
end;
*/

-- CASO 2

variable b_fechaactual varchar2(8);
exec :b_fechaactual := '23032023';

declare
    v_minid empleado.id_emp%type;
    v_maxid empleado.id_emp%type;
    v_numrun empleado.numrun_emp%type;
    v_dv empleado.dvrun_emp%type;
    v_idestciv empleado.id_estado_civil%type;
    v_nomestciv estado_civil.nombre_estado_civil%type;
    v_pnom empleado.pnombre_emp%type;
    v_nom varchar2(80);
    v_nomlargo number;
    v_fulluser varchar2(40);
    v_fullpassword varchar2(40);
    v_sueldo empleado.sueldo_base%type;
    v_fechacont empleado.fecha_contrato%type;
    v_fechatiempo varchar2(1);
begin
    select min(id_emp),
           max(id_emp)
    into v_minid, v_maxid
    from empleado;
    
    loop
        exit when v_minid > v_maxid;
        
        select numrun_emp,
               dvrun_emp,
               pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp,
               id_estado_civil,
               pnombre_emp,
               sueldo_base,
               fecha_contrato
        into v_numrun, v_dv, v_nom, v_idestciv, v_pnom, v_sueldo, v_fechacont
        from empleado
        where id_emp = v_minid;
        
        select nombre_estado_civil
        into v_nomestciv
        from estado_civil
        where id_estado_civil = v_idestciv;
        
        v_fechatiempo := case
                            when (to_number(substr(:b_fechaactual, -4)) - to_number(to_char(v_fechacont, 'yyyy'))) < 10 then 'X'
                            else ''
                        end;
        
        v_fulluser := substr(lower(v_nomestciv), 1, 1)|| substr(v_nom, 1, 3)|| length(v_pnom)||'*'|| substr(v_sueldo,-1,1)|| v_dv||
                      (to_number(substr(:b_fechaactual, -4)) - to_number(to_char(v_fechacont, 'yyyy'))) || v_fechatiempo;
        
        pl(v_minid
            ||' '|| v_numrun
            ||' '|| v_dv
            ||' '|| v_nom
            ||' '|| v_fulluser
        );
        
        v_minid := v_minid + 10;
    end loop;
    
    
end;
/






/*-- CASO 3

variable b_fecha varchar2(8);
exec :b_fecha := '23032023';
variable b_pct number;
exec :b_pct := 0.775;

declare
    v_minid number;
    v_maxid number;
    v_patente camion.nro_patente%type;
    v_valor_arr camion.valor_arriendo_dia%type;
    v_valor_ga camion.valor_garantia_dia%type;
    v_numarriendo number;    
begin
    -- ELIMINAR LOS DATOS DE LAS TABLAS DE DESTINO PARA FACILITAR EJECUCIONES MULTIPLES
    execute IMMEDIATE 'truncate table HIST_ARRIENDO_ANUAL_CAMION';

    -- CURSOR PARA RECUPERAR ID MINIMA Y MAXIMA
    select min(id_camion),
           max(id_camion)
    into v_minid, v_maxid
    from camion;
    
    -- BUCLE PARA ITERAR SOBRE LA TABLA CAMION
    loop
        exit when v_minid > v_maxid;
        
        -- CURSOR PRINCIPAL
        select nro_patente,
               valor_arriendo_dia,
               valor_garantia_dia
        into v_patente, v_valor_arr, v_valor_ga
        from camion
        where v_minid = id_camion;
        
        -- NUMERO DE ARRIENDOS DE UN CAMION
        select count(id_arriendo)
        into v_numarriendo
        from arriendo_camion
        where id_camion = v_minid
        and to_char(fecha_ini_arriendo, 'yyyy') = substr(:b_fecha, -4) -1;
        
        
        pl(substr(:b_fecha, -4)
        ||' ' || v_minid
        ||' '|| v_patente
        ||' '|| v_valor_arr
        ||' '|| v_valor_ga
        ||' '|| v_numarriendo
        );
        
        insert into hist_arriendo_anual_camion
        values(substr(:b_fecha, -4), v_minid, v_patente, v_valor_arr, v_valor_ga, v_numarriendo);
        
        v_minid := v_minid + 1;
    end loop;
    
    
    
end;
*/