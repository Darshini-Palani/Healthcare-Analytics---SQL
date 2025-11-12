Alter table appointments_1
add constraint fk_appointment
foreign key (patient_id) references patients_1 (patient_id);

alter table appointments_1
add constraint fk_appoint
foreign key (doctor_id) references doctors_1 (doctor_id);

alter table diagnoses_1
add constraint fk_patient
foreign key (patient_id) references patients_1 (patient_id);

alter table medications_1
add constraint fk_med
foreign key (diagnosis_id) references diagnoses_1 (diagnosis_id);

alter table diagnoses_1
add constraint fk_doc
foreign key (doctor_id) references doctors_1 (doctor_id);

select * from appointments_1;
select * from diagnoses_1;
select * from doctors_1;
select * from medications_1;
select * from patients_1;
-- Task 1
select b.name,c.name,c.specialization from appointments_1 as a
inner join patients_1 as b on a.patient_id = b.patient_id
inner join doctors_1 as c on a.doctor_id = c.doctor_id
where a.status = "completed";

-- Task 2
select a.name,a.contact_number,a.address from patients_1 as a
left join appointments_1 as b on a.patient_id = b.patient_id
where a.patient_id;
-- Task 3
select a.name,a.specialization,sum(b.diagnosis_id) as total_diagnosis from doctors_1 as a
right join diagnoses_1 as b on a.doctor_id = b.doctor_id
group by a.name,a.specialization;

-- Task 4
select * from appointments_1 as a 
inner join diagnoses_1 as b on a.doctor_id = b.doctor_id
where a.appointment_date <> b.diagnosis_date;
 
 
 
 -- Task 5
 select doctor_id,patient_id, rank () over (order by appointment_id desc) as Ranks from appointments_1;
 
 -- Task 6
 select age,count(case when age > 50 then "old age"
 when age > 30 then "middle age"
 when age >18 then "young age"
 else "child" end) as age_group from patients_1 
group by age;

-- Task 7 
select upper(name) as Name,contact_number from patients_1
where contact_number like '%1234' ;


-- Task 8
select name from patients_1 
where patient_id in (select patient_id from diagnoses_1   where diagnosis = "insulin");

-- Task 9
select medication_name,avg(datediff(end_date,start_date)) as Avg_date from medications_1
group by medication_name;

-- Task 10
select a.name,a.specialization,count(distinct c.patient_id) as count_patient from doctors_1 as a
inner join appointments_1 as b on a.doctor_id =b.doctor_id
inner join patients_1 as c on c.patient_id = b.patient_id
group by a.name,a.specialization order by count_patient desc


