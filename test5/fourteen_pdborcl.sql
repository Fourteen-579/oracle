create or replace PACKAGE MyPack IS
  /*
  ��ʵ����ʵ��4Ϊ������
  ��MyPack���У�
  һ������:Get_SaleAmount(V_DEPARTMENT_ID NUMBER)��
  һ������:Get_Employees(V_EMPLOYEE_ID NUMBER)
  */
  FUNCTION Get_SaleAmount(V_DEPARTMENT_ID NUMBER) RETURN NUMBER;
  PROCEDURE Get_Employees(V_EMPLOYEE_ID NUMBER);
END MyPack;
/
create or replace PACKAGE BODY MyPack IS
  FUNCTION Get_SaleAmount(V_DEPARTMENT_ID NUMBER) RETURN NUMBER
  AS
    N NUMBER(20,2); --ע�⣬����ORDERS.TRADE_RECEIVABLE��������NUMBER(8,2),����֮������Ҫ��öࡣ
    BEGIN
      SELECT SUM(O.TRADE_RECEIVABLE) into N  FROM ORDERS O,EMPLOYEES E
      WHERE O.EMPLOYEE_ID=E.EMPLOYEE_ID AND E.DEPARTMENT_ID =V_DEPARTMENT_ID;
      RETURN N;
    END;

  PROCEDURE GET_EMPLOYEES(V_EMPLOYEE_ID NUMBER)
  AS
    LEFTSPACE VARCHAR(2000);
    begin
      --ͨ��LEVEL�жϵݹ�ļ���
      LEFTSPACE:=' ';
      --ʹ���α�
      for v in
      (SELECT LEVEL,EMPLOYEE_ID,NAME,MANAGER_ID FROM employees
      START WITH EMPLOYEE_ID = V_EMPLOYEE_ID
      CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID)
      LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(LEFTSPACE,(V.LEVEL-1)*4,' ')||
                             V.EMPLOYEE_ID||' '||v.NAME);
      END LOOP;
    END;
END MyPack;
/


/*
���ԣ�

����Get_SaleAmount()���Է�����
select count(*) from orders;
select MyPack.Get_SaleAmount(11) AS ����11Ӧ�ս��,MyPack.Get_SaleAmount(12) AS ����12Ӧ�ս�� from dual;


����Get_Employees()���Դ��룺
set serveroutput on
DECLARE
  V_EMPLOYEE_ID NUMBER;    
BEGIN
  V_EMPLOYEE_ID := 1;
  MYPACK.Get_Employees (  V_EMPLOYEE_ID => V_EMPLOYEE_ID) ;  
  V_EMPLOYEE_ID := 11;
  MYPACK.Get_Employees (  V_EMPLOYEE_ID => V_EMPLOYEE_ID) ;    
END;
/
�����
1 ��³�
    11 ����
        111 �⾭��
        112 �׾���
    12 ����
        121 �Ծ���
        122 ������
11 ����
    111 �⾭��
    112 �׾���
*/