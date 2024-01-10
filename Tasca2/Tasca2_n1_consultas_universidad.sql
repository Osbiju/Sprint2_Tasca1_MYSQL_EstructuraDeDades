USE universidad;

-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT
	persona.apellido1,
    persona.apellido2,
    persona.nombre
FROM persona
WHERE persona.tipo = 'alumno'
ORDER BY 
	persona.apellido1,
    persona.apellido2,
    persona.nombre;
    
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT 
	persona.apellido1,
    persona.apellido2,
    persona.nombre
FROM persona
WHERE 
	persona.tipo = 'alumno'
    AND ISNULL(persona.telefono);
    
-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT 
    persona.apellido1,
    persona.apellido2,
    persona.nombre
FROM persona
WHERE
    persona.tipo = 'alumno' AND YEAR(persona.fecha_nacimiento)=1999;
    
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT 
    persona.apellido1,
    persona.apellido2,
    persona.nombre
FROM persona
WHERE
    persona.tipo = 'profesor' 
    AND ISNULL(persona.telefono) 
    AND persona.nif LIKE '%K';
    
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT *
FROM asignatura
WHERE asignatura.cuatrimestre = 1 
AND curso = 3 
AND asignatura.id_grado = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT
    persona.apellido1,
    persona.apellido2,
    persona.nombre,
    profesor.id_profesor,
    departamento.nombre
FROM profesor
INNER JOIN persona ON profesor.id_profesor = persona.id
INNER JOIN departamento ON profesor.id_departamento = departamento.id;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT
    asignatura.nombre,
    curso_escolar.anyo_inicio,
    curso_escolar.anyo_fin
FROM alumno_se_matricula_asignatura
JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE
    alumno_se_matricula_asignatura.id_alumno =(
    SELECT persona.id
    FROM persona
    WHERE persona.nif = '26902806M'
);

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT
    departamento.nombre
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
    
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT
    persona.nombre,
    persona.apellido1,
    persona.apellido2
FROM alumno_se_matricula_asignatura
JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE
    curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;
    
-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT
    departamento.nombre AS nom_departamento,
    CONCAT(
        persona.apellido1,
        persona.apellido2) AS cognoms_profesor,
		persona.nombre AS nom_profesor
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE persona.tipo = 'profesor'
ORDER BY
    departamento.nombre,
    cognoms_profesor,
    persona.nombre;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT
    departamento.nombre AS nom_departamento,
    CONCAT(
        persona.apellido1,
        persona.apellido2
    ) AS cognoms_profesor,
    persona.nombre AS nom_profesor
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE
    profesor.id_departamento IS NULL AND persona.tipo = 'profesor'
ORDER BY
    departamento.nombre,
    cognoms_profesor,
    persona.nombre;	

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT
    departamento.nombre AS nom_departamento,
    departamento.id
FROM departamento
LEFT JOIN profesor ON profesor.id_departamento = departamento.id
WHERE profesor.id_departamento IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT
    profesor.id_profesor
FROM profesor
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE profesor.id_profesor IS NULL;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT
    asignatura.nombre,
    asignatura.ID
FROM profesor
RIGHT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor 
WHERE asignatura.id IS NULL;

-- Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(persona.id) AS 'nombre total alumnes'
FROM persona
WHERE persona.tipo + 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(persona.id) AS 'alumnes nascuts 1999'
FROM persona
WHERE persona.tipo + 'alumno' AND YEAR(persona.fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT
    departamento.nombre AS nom_departamento,
    COUNT(*)  AS nombre_profesor
FROM departamento
INNER JOIN 
	profesor ON departamento.id = profesor.id_departamento
GROUP BY nom_departamento
ORDER BY nombre_profesor DESC;
    
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT
    departamento.nombre AS nom_departamento,
    COUNT(profesor.id_profesor) AS nombre_profesor
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre
ORDER BY COUNT(profesor.id_profesor) DESC;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT
    grado.nombre AS nom_grau,
    COUNT(asignatura.id) AS nombre_asignatura
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY COUNT(asignatura.id) DESC;
    
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id) AS número_asignaturas 
FROM grado 
INNER JOIN asignatura ON grado.id = asignatura.id_grado 
GROUP BY grado.nombre HAVING número_asignaturas > 40;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT 
	grado.nombre, 
    asignatura.tipo, 
    SUM(asignatura.creditos) AS suma_creditos_asignatura 
FROM grado 
INNER JOIN asignatura ON grado.id = asignatura.id_grado 
GROUP BY grado.nombre, asignatura.tipo;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT 
	curso_escolar.anyo_inicio,
    COUNT(persona.id) AS número_alumnos_matriculados 
FROM curso_escolar 
LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar 
LEFT JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id 
GROUP BY curso_escolar.anyo_inicio;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT 
	profesor.id_profesor,
    persona.nombre, 
    persona.apellido1, 
    persona.apellido2, 
    COUNT(asignatura.id) AS número_asignaturas 
FROM profesor 
INNER JOIN persona ON profesor.id_profesor = persona.id 
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor 
GROUP BY profesor.id_profesor 
ORDER BY número_asignaturas DESC;

-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT *
FROM persona 
WHERE persona.tipo = "alumno" && persona.fecha_nacimiento = (SELECT MAX(persona.fecha_nacimiento)
FROM persona);

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT 
	persona.nombre,
    persona.apellido1, 
    persona.apellido2 
FROM persona 
INNER JOIN profesor ON persona.id = profesor.id_profesor 
INNER JOIN departamento ON profesor.id_departamento = departamento.id 
LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;