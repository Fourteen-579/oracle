/*创建用户表数据*/
create or replace procedure insert_users(p_u_id users.u_id%type, p_uname users.uname%type, p_sex users.sex%type, p_age users.age%type,
p_connact users.connact%type,p_m_history users.m_history%type, p_medicine users.medicine%type, p_allergen users.allergen%type,p_e_num users.e_num%type)
is
begin
insert into users
values(p_u_id, p_uname, p_sex, p_age, p_connact,p_m_history,p_medicine,p_allergen,p_e_num) ;
end;

/*创建专家表数据*/
create or replace procedure insert_expert(x_e_num expert.e_num%type,x_e_name expert.e_name%type,x_e_sex expert.e_sex%type,
x_e_connact expert.e_connact%type, x_e_post expert.e_post%type)
is
begin
insert into expert
values(x_e_num, x_e_name,x_e_sex,x_e_connact,x_e_post) ;
end;

/*创建投诉表数据*/
create or replace procedure insert_complaint(z_c_num complaint.c_num%type, z_u_id complaint.u_id%type, z_c_time complaint.C_time%type,
 z_c_content complaint.c_content%type)
begin
insert into complaint
values(z_c_num,z_u_id,z_c_time,z_c_content) ;
end;

/*创建症状表数据*/
create or replace procedure insert features(n_f_num features.f_num%type, n_u_id features.u_id%type,n_f_severity feaures.f_severity%type,
n_f_des features.f_des%type,n_f_time features.f_time%type)
is
begin
insert into features
values(n_f_num,n_u_id,n_f_severity,n_f_des,n_f_time) ;
end;

/*创建诊断表数据*/
create or replace procedure insert_diagnose(v_f_num diagnose.f_num%type, v_e_num diagnose.e_num%type, v_d_name diagnose.d_name%type,
v_d_type diagnose.d_type%type, v_d_time diagnose.d_time%type, v_d_des diagnose.d_des%type, v_d_suggest diagnose.d_sugges t%type)
begin
insert into diagnose
values(v_f_num, v_e_num, v_d name, v_d_type, v_d_time, v_d_des, v_d_suggest) ;
end ;

/*创建问题表数据*/
create or replace procedure insert_prob1em(z_p_num problem.p_num%type,z_u id problem.u_id%type,z_p_title problem.p_title%type,
 z_p_type problem.p_type%type, z_p_time problem.p_time%type, z_p_text problem.p_text%type)
is
begin
insert into probl em
values(z_p num,z_u_id,z_p_title,z_p_type,z_p_time,z_p_text) ;
end;

/*创建回答表数据*/
create or replace procedure insert_answer(m_p_num answer.p_num%type, m_e_num answer.e_num%type,m_a_time answer.a_tine%type,
m_a_text answer.a_text%type,m_a_type answer.a_type%type)
is
begin
insert into answer
values(m_p_num,m_e_num,m_a_time,m_a_text,m_a_type) ;
end;

/*创建测试表数据*/
create or replace procedure insert_beta(j_u_id beta.u_id%type, j_b_num beta.b_num%type, j_b_time beta.b_time%type, j_process beta.b_process%type,
 j_b_condtion beta.b_condtion%type, j_b_method beta.b_method%type, j_b_out beta.b_out%type)
is
begin
insert into beta
values(j_u_id, j_b_num, j_b_time, j_b_process, j_b_condtion, j_b_method, j_b_out) ;
end;

/*创建治疗表数据*/
create or replace procedure insert_treat(l_b_num treat.b_num%type, l_e_num treat.e_num%type, l_t_name treat.t_name%type,
 l_t_type treat.t_type%type, l_t_des treat.t_des%type)
is
begin
insert into treat
values(l_b_num, l_e_num, l_t_name, l_t_type, l_t_des) ;
end;

/*创建注册表数据*/
create or replace procedure insert_use_info(o_useid use_info.useid%type, o_password use_info.password%type, o_type use_info.type%type)
is
begin
insert into use_info
values(o_useid, o_password,o_type) ;
end;


/*创建视图1*/
create view p_ answer
as select users.u_id, uname, p_title, p_type, p_time, p_text, a_text, a_time
from users, problem, answer
where users. u_id=problem.u_id and problem.p_num=answe.p_num;

/*创建视图2*/
create view f_diagnose
as select users.uname, f_severity, f_des, f_time, d_name, d_type, d_time, e_name
from users, features, diagnose, expert
where users.u_id=features.u_id and features.f_num=diagnose.f_num and diagnose.e_num=expert.e_num; 

/*创建函数1*/
create or replace function count_s(enu expert.e_num%type)
return number is
rowcount number;
begin
select count (e_num)
into rowcount
from answer
where e_num=enu;
return rowcount;
end;
/

/*创建函数2*/
create or replace function sev_u(uid users.u_id%type)
return varchar2 is
usss users%rowtype;
begin
select * into usss
from users
where u_id=uid;
return ('姓名:'||usss. uname||'年龄:' ||'usss. age'||'性别: '||usss. sex||'联系方式: '||usss. connact);
end;
/

/*存储过程1*/
create or replace procedure update_answer(u_p_num answer.p_num%type,u_e_num answer.e_num%type,u_a_text answe.a_text%type)
begin
update answer
set a_text=u_a_text 
where answer.p_num=u_p_num and answer.e_num=u_e_num;
end;
/

/*存储过程2*/
create or replace procedure se_users
is
v_name users.uname%type;
begin
select uname into v_name 
from users
where uname like '李%';
end;
/









