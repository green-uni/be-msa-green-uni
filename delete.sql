-- ========================================================================
-- delete.sql - 전체 더미데이터 초기화 스크립트
-- 실행: HeidiSQL에서 이 파일 전체 실행 (F9)
-- 주의: data.sql 재실행 전 반드시 이 파일 먼저 실행
-- ========================================================================

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 1. gu_academic (자식 테이블부터)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_academic;
DELETE FROM announcement;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 2. gu_core (자식 → 부모 순서)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_core;
DELETE FROM grade;
DELETE FROM attendance;
DELETE FROM attendance_session;
DELETE FROM course;
DELETE FROM lecture_schedule;
DELETE FROM lecture;
DELETE FROM scholarship_type;
DELETE FROM tuition_policy;
DELETE FROM eval_period;
DELETE FROM schedule_cache;
DELETE FROM student_cache;
DELETE FROM professor_cache;

-- major.professor_code FK 제약 해제 후 삭제
UPDATE major SET professor_code = NULL;
DELETE FROM classroom;
DELETE FROM major;
DELETE FROM college;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 3. gu_member (자식 → 부모 순서)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_member;
DELETE FROM student_major;
DELETE FROM student;
DELETE FROM professor;
DELETE FROM admin;
DELETE FROM member;
DELETE FROM major_cache;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 4. gu_auth (마지막)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_auth;
DELETE FROM auth_member;