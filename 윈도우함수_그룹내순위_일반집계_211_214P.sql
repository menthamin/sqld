/* WINDOW FUNCTION, 211P �׷� �� ���� �Լ� */
-- RANK �Լ� (���� �浹)
SELECT JOB, ENAME, SAL, 
    RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
    RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
    FROM EMP;

-- ����
SELECT JOB, ENAME, SAL, 
    RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
    RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
    FROM EMP
ORDER BY JOB;

-- JOB �������� ������ ����.
SELECT JOB, ENAME, SAL, 
    RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
    FROM EMP;

-- DENSE_RANK �Լ� (������ ������ �ϳ��� �Ǽ��� ���)
SELECT JOB, ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) RANK,
    DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK
    FROM EMP;
    
-- ROW_NUMBER �Լ� ������ ���̶� ������ ������ �ο��Ѵ�.
-- ���� ���� ���� �������� �����ϰ� �ʹٸ� ORDER BY SAL DESC, ENAME) ���� ORDERY BY ���� �̿��� �߰����� ���� ���� ���� �ʿ�
SELECT JOB, ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) RANK,
    ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUMBER 
    FROM EMP;
    
SELECT JOB, ENAME, SAL, RANK() OVER (ORDER BY SAL DESC) RANK,
    ROW_NUMBER() OVER (ORDER BY SAL DESC, ENAME) ROW_NUMBER 
    FROM EMP;
    
/* WINDOW FUNCTION �Ϲ� �����Լ� 212P~ */
-- SUM �Լ�
-- PARTITION, RANGE UNBOUNDED PRECEDING
SELECT MGR, ENAME, SAL, 
    SUM(SAL) OVER (PARTITION BY MGR) MGR_SUM 
    -- PARTITION BY MGR�� �Ŵ������� �����͸� ��Ƽ��ȭ
    FROM EMP;

SELECT MGR, ENAME, SAL,
    SUM(SAL) OVER (PARTITION BY MGR ORDER BY SAL RANGE UNBOUNDED PRECEDING) AS MGR_SUM
    FROM EMP; -- RANGE UNBOUNDED PRECEDING ���� ���� �������� ��Ƽ�� ���� ù ��° ������� ������ �����Ѵ�.

-- MAX    
-- ��Ƽ�Ǻ� �������� �ִ밪�� ����
SELECT MGR, ENAME, SAL,
    MAX(SAL) OVER (PARTITION BY MGR) AS MAR_MAX
    FROM EMP;

-- INLINE VIEW�� �̿��� ��Ƽ�Ǻ� �ִ밪�� ���� �ุ ����
SELECT MGR, ENAME, SAL, IV_MAX_SAL FROM 
    (SELECT MGR, ENAME, SAL,
    MAX(SAL) OVER (PARTITION BY MGR) AS IV_MAX_SAL
    FROM EMP)
    WHERE SAL = IV_MAX_SAL;

-- MIN �Լ� ��Ƽ�Ǻ� �ּ� ��
SELECT MGR, ENAME, TO_CHAR(HIREDATE, 'YYYY-MM-DD') AS H_DATE, SAL,
    MIN(SAL) OVER (PARTITION BY MGR ORDER BY HIREDATE) AS MGR_MIN
    FROM EMP;
    
-- AVG �Լ�
-- EMP ���̺��� ���� �Ŵ����� �ΰ� �ִ� ������� ��� SALARY�� ���ϴµ�, ������
-- ���� �Ŵ��� ������ �ڱ� �ٷ� ���� ����� �ٷ� ���� ����� �������� ������� �Ѵ�.
-- �տ� �����Ͱ� ������� : �ڱ��ڽ� + �ٷε�
-- �ڿ� �����Ͱ� ���� ��� : �� + �ڱ��ڽ�
-- �յ� �����Ͱ� ��� ���� ��� : ��, �ڱ�, ��
-- �����Ͱ� �ڱ⸸ ���� ��� : �ڽ�
SELECT MGR, ENAME, HIREDATE, SAL,
    ROUND (AVG(SAL) OVER (PARTITION BY MGR ORDER BY HIREDATE 
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) AS MGR_AVG
    FROM EMP;

-- ��Ƽ���� �������� �ʾ����Ƿ� ��� �Ǽ��� ������� -50 ~ +150 ���ؿ� �´��� �˻��Ѵ�.
SELECT ENAME, SAL,
    COUNT(*) OVER (ORDER BY SAL RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING) AS SIM_CNT
    FROM EMP;
    