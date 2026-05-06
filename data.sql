-- [PART 1/6] gu_core - 기준 데이터 (단과대·학과·강의실·시설·학사일정 캐시)
-- ========================================================================
-- 그린uni 통합 더미데이터 INSERT 스크립트
-- 회원: 관리자 3 + 교수 10 + 학생 100
-- 강의: 50개 / 수강신청 / 출석 / 성적 포함
-- BCrypt 비밀번호: 평문 "1234"
-- 실행: HeidiSQL에서 위→아래 순서대로 한 번에 실행
-- ========================================================================

USE my_gu_core;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 1. 단과대학 (8개 - 규칙 8번)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO college (college_id, name) VALUES
                                           (1, '인문대학'), (2, '자연과학대학'), (3, '사회과학대학'), (4, '공과대학'),
                                           (5, '예술대학'), (6, '경영대학'), (7, '사범대학'), (8, '체육대학');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 2. 학과 (8개 - professor_code는 교수 INSERT 후 UPDATE)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO major (major_id, name, active, college_id, room, tel, professor_code, capacity, major_building, info, created_at) VALUES
 (101, '국어국문학과', 'RUNNING', 1, '인문관 101호', '02-1234-1001', NULL,30, '인문관', NULL,'2020-01-01 00:00:00'),
 (102, '영어영문학과', 'RUNNING', 1, '인문관 102호', '02-1234-1002', NULL, 30, '인문관',NULL,'2020-01-01 00:00:00'),
 (201, '수학과', 'RUNNING', 2, '자연관 201호', '02-1234-2001', NULL, 25, '자연과학관', NULL,'2020-01-01 00:00:00'),
 (202, '물리학과', 'RUNNING', 2, '자연관 202호', '02-1234-2002', NULL, 25, '자연과학관', NULL,'2020-01-01 00:00:00'),
 (301, '심리학과', 'RUNNING', 3, '사회관 301호', '02-1234-3001', NULL, 30, '사회과학관', NULL,'2020-01-01 00:00:00'),
 (401, '컴퓨터공학과', 'RUNNING', 4, '공학관 401호', '02-1234-4001', NULL, 35, '공학관', NULL,'2020-01-01 00:00:00'),
 (402, '전자공학과', 'RUNNING', 4, '공학관 402호', '02-1234-4002', NULL, 30, '공학관', NULL,'2020-01-01 00:00:00'),
 (601, '경영학과', 'RUNNING', 6, '경영관 601호', '02-1234-6001', NULL, 40, '경영관', NULL,'2020-01-01 00:00:00');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 3. 강의실 (classroom) .. 아래 6-A에서 실행하기때문에 삭제
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 4번은 시설에 대한 더미데이터여서 제외하였음.

-- [PART 2/6] gu_core 학사일정 캐시 (수강신청 기간 등)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 5. 학사일정 캐시 (schedule_cache) - 규칙 17번
-- 현재(2026-04-30) 기준으로 활성화 상태를 다양화
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO schedule_cache (schedule_id, type, year, semester, start_date, end_date, is_active) VALUES
-- 2026년 1학기 (현재 진행 중)
(7001, 'COURSE_REGISTRATION', 2026, 1, '2026-02-01 09:00:00', '2026-02-15 18:00:00', FALSE),  -- 종료
(7002, 'COURSE_MODIFICATION', 2026, 1, '2026-03-02 09:00:00', '2026-03-08 18:00:00', FALSE),  -- 종료
(7003, 'COURSE_OPEN',         2026, 1, '2026-03-02 09:00:00', '2026-06-20 23:59:59', TRUE),   -- 진행 중
(7004, 'TUITION_PAYMENT',     2026, 1, '2026-02-20 09:00:00', '2026-03-15 23:59:59', FALSE),  -- 종료
(7005, 'GRADE_INPUT',         2026, 1, '2026-06-15 09:00:00', '2026-07-05 18:00:00', FALSE),  -- 미시작
(7006, 'GRADE_VIEW',          2026, 1, '2026-07-10 09:00:00', '2026-07-25 23:59:59', FALSE),  -- 미시작
(7007, 'GRADE_APPEAL',        2026, 1, '2026-07-26 09:00:00', '2026-08-05 18:00:00', FALSE),  -- 미시작
(7008, 'LECTURE_EVALUATION',  2026, 1, '2026-06-01 09:00:00', '2026-06-30 23:59:59', FALSE),  -- 미시작

-- 2026년 2학기 (수강신청 - 활성화 상태로 두어 테스트 가능하도록)
(7009, 'COURSE_REGISTRATION', 2026, 2, '2026-08-10 09:00:00', '2026-08-25 18:00:00', FALSE),  -- 미시작
(7010, 'COURSE_MODIFICATION', 2026, 2, '2026-09-01 09:00:00', '2026-09-07 18:00:00', FALSE),  -- 미시작
(7011, 'COURSE_OPEN',         2026, 2, '2026-09-01 09:00:00', '2026-12-19 23:59:59', FALSE),  -- 미시작
(7012, 'TUITION_PAYMENT',     2026, 2, '2026-08-20 09:00:00', '2026-09-15 23:59:59', FALSE),  -- 미시작

-- 2025년 2학기 (종료 - 강의평가 등 테스트용)
(7013, 'COURSE_REGISTRATION', 2025, 2, '2025-08-10 09:00:00', '2025-08-25 18:00:00', FALSE),
(7014, 'GRADE_INPUT',         2025, 2, '2025-12-15 09:00:00', '2026-01-05 18:00:00', FALSE),
(7015, 'GRADE_VIEW',          2025, 2, '2026-01-10 09:00:00', '2026-01-25 23:59:59', FALSE),
(7016, 'LECTURE_EVALUATION',  2025, 2, '2025-12-01 09:00:00', '2025-12-30 23:59:59', FALSE);

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 6. 강의평가 기간 (eval_period)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO eval_period (year, semester, start_date, end_date) VALUES
                                                                   (2025, 2, '2025-12-01 09:00:00', '2025-12-30 23:59:59'),
                                                                   (2026, 1, '2026-06-01 09:00:00', '2026-06-30 23:59:59');


-- [PART 3/6] gu_auth 인증 회원 (관리자 3 + 교수 10 + 학생 100)

USE my_gu_auth;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 7. 인증 회원 (auth_member) - 비밀번호: BCrypt("1234")
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- 관리자 3명
INSERT INTO auth_member (member_code, password, role, email, is_active, is_first_login, created_at) VALUES
                                                                                                        (20203001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'ADMIN', 'admin01@green.ac.kr', TRUE, TRUE, '2020-03-02 09:00:00'),
                                                                                                        (20223001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'ADMIN', 'admin02@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
                                                                                                        (20253001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'ADMIN', 'admin03@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00');

-- 교수 10명
INSERT INTO auth_member (member_code, password, role, email, is_active, is_first_login, created_at) VALUES
                                                                                                        (20002001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof01@green.ac.kr', TRUE, TRUE, '2000-03-02 09:00:00'),
                                                                                                        (20052001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof02@green.ac.kr', TRUE, TRUE, '2005-03-02 09:00:00'),
                                                                                                        (20082001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof03@green.ac.kr', TRUE, TRUE, '2008-03-02 09:00:00'),
                                                                                                        (20102001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof04@green.ac.kr', TRUE, TRUE, '2010-03-02 09:00:00'),
                                                                                                        (20122001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof05@green.ac.kr', TRUE, TRUE, '2012-03-02 09:00:00'),
                                                                                                        (20132001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof06@green.ac.kr', TRUE, TRUE, '2013-03-02 09:00:00'),
                                                                                                        (20152001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof07@green.ac.kr', TRUE, TRUE, '2015-03-02 09:00:00'),
                                                                                                        (20172001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof08@green.ac.kr', TRUE, TRUE, '2017-03-02 09:00:00'),
                                                                                                        (20182001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof09@green.ac.kr', TRUE, TRUE, '2018-03-02 09:00:00'),
                                                                                                        (20202001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'PROFESSOR', 'prof10@green.ac.kr', TRUE, TRUE, '2020-03-02 09:00:00');

-- 학생 100명
INSERT INTO auth_member (member_code, password, role, email, is_active, is_first_login, created_at) VALUES
-- 2026학번 20명
(20261001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026001@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261002, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026002@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261003, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026003@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261004, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026004@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261005, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026005@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261006, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026006@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261007, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026007@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261008, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026008@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261009, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026009@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261010, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026010@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261011, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026011@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261012, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026012@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261013, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026013@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261014, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026014@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261015, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026015@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261016, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026016@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261017, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026017@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261018, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026018@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261019, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026019@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
(20261020, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2026020@green.ac.kr', TRUE, TRUE, '2026-03-02 09:00:00'),
-- 2025학번 25명
(20251001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025001@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251002, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025002@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251003, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025003@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251004, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025004@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251005, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025005@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251006, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025006@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251007, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025007@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251008, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025008@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251009, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025009@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251010, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025010@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251011, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025011@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251012, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025012@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251013, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025013@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251014, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025014@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251015, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025015@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251016, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025016@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251017, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025017@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251018, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025018@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251019, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025019@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251020, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025020@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251021, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025021@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251022, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025022@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251023, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025023@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251024, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025024@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
(20251025, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2025025@green.ac.kr', TRUE, TRUE, '2025-03-02 09:00:00'),
-- 2024학번 25명
(20241001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024001@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241002, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024002@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241003, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024003@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241004, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024004@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241005, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024005@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241006, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024006@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241007, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024007@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241008, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024008@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241009, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024009@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241010, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024010@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241011, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024011@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241012, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024012@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241013, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024013@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241014, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024014@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241015, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024015@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241016, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024016@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241017, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024017@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241018, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024018@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241019, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024019@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241020, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024020@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241021, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024021@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241022, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024022@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241023, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024023@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241024, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024024@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
(20241025, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2024025@green.ac.kr', TRUE, TRUE, '2024-03-02 09:00:00'),
-- 2023학번 20명
(20231001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023001@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231002, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023002@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231003, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023003@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231004, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023004@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231005, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023005@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231006, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023006@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231007, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023007@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231008, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023008@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231009, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023009@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231010, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023010@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231011, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023011@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231012, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023012@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231013, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023013@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231014, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023014@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231015, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023015@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231016, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023016@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231017, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023017@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231018, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023018@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231019, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023019@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
(20231020, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2023020@green.ac.kr', TRUE, TRUE, '2023-03-02 09:00:00'),
-- 2022학번 10명
(20221001, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022001@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221002, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022002@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221003, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022003@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221004, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022004@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221005, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022005@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221006, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022006@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221007, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022007@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221008, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022008@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221009, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022009@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00'),
(20221010, '$2a$10$wkRgT1JAbnStJzruQHKEeedMSveJVCiMGMz6V2OFHv7W2UgVn6Sw', 'STUDENT', 'std2022010@green.ac.kr', TRUE, TRUE, '2022-03-02 09:00:00');


-- [PART 4/6] gu_member - 회원 정보
USE my_gu_member;

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 8. 학과 캐시 (major_cache)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO major_cache (major_id, name, college_name) VALUES
                                                           (101, '국어국문학과', '인문대학'),
                                                           (102, '영어영문학과', '인문대학'),
                                                           (201, '수학과',       '자연과학대학'),
                                                           (202, '물리학과',     '자연과학대학'),
                                                           (301, '심리학과',     '사회과학대학'),
                                                           (401, '컴퓨터공학과', '공과대학'),
                                                           (402, '전자공학과',   '공과대학'),
                                                           (601, '경영학과',     '경영대학');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 9. 회원 공통정보 (member) - 113명 (관리자3 + 교수10 + 학생100)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- 관리자 3명
INSERT INTO member (member_code, email, name, birth, tel, emergency_tel, postcode, address, detail_address, entry_date, exit_date, pic, created_at) VALUES
                                                                                                                                                        (20203001, 'admin01@green.ac.kr', '김행정', '1985-04-12', '01011112222', '01099998888', '06234', '서울특별시 강남구 테헤란로 123', '301호',  '2020-03-02', NULL, NULL, '2020-03-02 09:00:00'),
                                                                                                                                                        (20223001, 'admin02@green.ac.kr', '이관리', '1990-08-23', '01022223333', '01088887777', '04567', '서울특별시 마포구 월드컵북로 50', '102호',  '2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
                                                                                                                                                        (20253001, 'admin03@green.ac.kr', '박운영', '1995-01-30', '01033334444', '01077776666', '05678', '서울특별시 송파구 올림픽로 240', '1505호', '2025-03-02', NULL, NULL, '2025-03-02 09:00:00');

-- 교수 10명
INSERT INTO member (member_code, email, name, birth, tel, emergency_tel, postcode, address, detail_address, entry_date, exit_date, pic, created_at) VALUES
                                                                                                                                                        (20002001, 'prof01@green.ac.kr', '정교수', '1965-05-20', '01044440001', '01066660001', '03781', '서울특별시 종로구 율곡로 100',     '202호',  '2000-03-02', NULL, NULL, '2000-03-02 09:00:00'),
                                                                                                                                                        (20052001, 'prof02@green.ac.kr', '김지혜', '1972-09-15', '01044440002', '01066660002', '04023', '서울특별시 강서구 화곡로 200',     '501호',  '2005-03-02', NULL, NULL, '2005-03-02 09:00:00'),
                                                                                                                                                        (20082001, 'prof03@green.ac.kr', '장현석', '1975-03-08', '01044440003', '01066660003', '06234', '서울특별시 강남구 봉은사로 100',   '703호',  '2008-03-02', NULL, NULL, '2008-03-02 09:00:00'),
                                                                                                                                                        (20102001, 'prof04@green.ac.kr', '이상민', '1978-11-08', '01044440004', '01066660004', '06234', '서울특별시 서초구 강남대로 300',   '801호',  '2010-03-02', NULL, NULL, '2010-03-02 09:00:00'),
                                                                                                                                                        (20122001, 'prof05@green.ac.kr', '오수진', '1980-06-21', '01044440005', '01066660005', '03781', '서울특별시 종로구 새문안로 80',    '901호',  '2012-03-02', NULL, NULL, '2012-03-02 09:00:00'),
                                                                                                                                                        (20132001, 'prof06@green.ac.kr', '신미래', '1982-02-14', '01044440006', '01066660006', '07212', '서울특별시 영등포구 의사당대로 1', '1101호', '2013-03-02', NULL, NULL, '2013-03-02 09:00:00'),
                                                                                                                                                        (20152001, 'prof07@green.ac.kr', '박철수', '1983-03-25', '01044440007', '01066660007', '07212', '서울특별시 영등포구 여의대로 50',  '1201호', '2015-03-02', NULL, NULL, '2015-03-02 09:00:00'),
                                                                                                                                                        (20172001, 'prof08@green.ac.kr', '문지현', '1985-10-30', '01044440008', '01066660008', '04567', '서울특별시 마포구 마포대로 100',   '1303호', '2017-03-02', NULL, NULL, '2017-03-02 09:00:00'),
                                                                                                                                                        (20182001, 'prof09@green.ac.kr', '류성호', '1986-12-19', '01044440009', '01066660009', '03781', '서울특별시 종로구 종로 200',       '1405호', '2018-03-02', NULL, NULL, '2018-03-02 09:00:00'),
                                                                                                                                                        (20202001, 'prof10@green.ac.kr', '최영희', '1980-12-11', '01044440010', '01066660010', '08234', '서울특별시 관악구 관악로 1',       '305호',  '2020-03-02', NULL, NULL, '2020-03-02 09:00:00');

-- 학생 100명 (간결한 더미 - 실제 운영 가능 수준)
INSERT INTO member (member_code, email, name, birth, tel, emergency_tel, postcode, address, detail_address, entry_date, exit_date, pic, created_at) VALUES
-- 2026학번 20명
(20261001, 'std2026001@green.ac.kr', '김민준', '2007-03-15', '01010260001', '01099260001', '06234', '서울특별시 강남구 논현로 100', '101호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261002, 'std2026002@green.ac.kr', '이서연', '2007-05-22', '01010260002', '01099260002', '04567', '서울특별시 마포구 양화로 50',  '202호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261003, 'std2026003@green.ac.kr', '박지호', '2007-07-03', '01010260003', '01099260003', '05678', '서울특별시 송파구 백제로 30',  '303호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261004, 'std2026004@green.ac.kr', '정수아', '2007-08-18', '01010260004', '01099260004', '07212', '서울특별시 영등포구 도림로 20','404호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261005, 'std2026005@green.ac.kr', '최건우', '2007-09-10', '01010260005', '01099260005', '08234', '서울특별시 관악구 봉천로 88',  '505호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261006, 'std2026006@green.ac.kr', '강나래', '2007-11-25', '01010260006', '01099260006', '04023', '서울특별시 강서구 공항로 150', '606호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261007, 'std2026007@green.ac.kr', '윤도하', '2007-12-30', '01010260007', '01099260007', '03781', '서울특별시 종로구 사직로 75',  '707호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261008, 'std2026008@green.ac.kr', '한예린', '2007-04-12', '01010260008', '01099260008', '06234', '서울특별시 서초구 반포로 250', '808호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261009, 'std2026009@green.ac.kr', '오태양', '2007-06-08', '01010260009', '01099260009', '04567', '서울특별시 마포구 독막로 100', '909호', '2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261010, 'std2026010@green.ac.kr', '서지안', '2007-10-21', '01010260010', '01099260010', '05678', '서울특별시 송파구 위례로 50',  '1010호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261011, 'std2026011@green.ac.kr', '임채원', '2007-01-14', '01010260011', '01099260011', '07212', '서울특별시 영등포구 영중로 30','1111호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261012, 'std2026012@green.ac.kr', '조하민', '2007-02-28', '01010260012', '01099260012', '08234', '서울특별시 관악구 신림로 200', '1212호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261013, 'std2026013@green.ac.kr', '신유찬', '2007-03-19', '01010260013', '01099260013', '04023', '서울특별시 강서구 양천로 70',  '1313호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261014, 'std2026014@green.ac.kr', '권시아', '2007-05-04', '01010260014', '01099260014', '03781', '서울특별시 종로구 인사동 12',  '1414호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261015, 'std2026015@green.ac.kr', '백선우', '2007-07-26', '01010260015', '01099260015', '06234', '서울특별시 강남구 학동로 300', '1515호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261016, 'std2026016@green.ac.kr', '문가은', '2007-08-09', '01010260016', '01099260016', '04567', '서울특별시 마포구 성지길 50',  '1616호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261017, 'std2026017@green.ac.kr', '안재훈', '2007-10-03', '01010260017', '01099260017', '05678', '서울특별시 송파구 가락로 90',  '1717호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261018, 'std2026018@green.ac.kr', '송하늘', '2007-11-17', '01010260018', '01099260018', '07212', '서울특별시 영등포구 국회로 100','1818호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261019, 'std2026019@green.ac.kr', '홍지유', '2007-12-05', '01010260019', '01099260019', '08234', '서울특별시 관악구 남부순환로 1500','1919호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
(20261020, 'std2026020@green.ac.kr', '구도현', '2007-04-23', '01010260020', '01099260020', '04023', '서울특별시 강서구 마곡로 90',  '2020호','2026-03-02', NULL, NULL, '2026-03-02 09:00:00'),
-- 2025학번 25명
(20251001, 'std2025001@green.ac.kr', '김도현', '2006-01-10', '01010250001', '01099250001', '06234', '서울특별시 강남구 압구정로 100','101호', '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251002, 'std2025002@green.ac.kr', '이가영', '2006-02-22', '01010250002', '01099250002', '04567', '서울특별시 마포구 합정로 50', '202호',  '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251003, 'std2025003@green.ac.kr', '박서준', '2006-03-15', '01010250003', '01099250003', '05678', '서울특별시 송파구 잠실로 30', '303호',  '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251004, 'std2025004@green.ac.kr', '정유진', '2006-04-08', '01010250004', '01099250004', '07212', '서울특별시 영등포구 신길로 20','404호', '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251005, 'std2025005@green.ac.kr', '최민서', '2006-05-19', '01010250005', '01099250005', '08234', '서울특별시 관악구 신원로 88', '505호',  '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251006, 'std2025006@green.ac.kr', '강하윤', '2006-06-30', '01010250006', '01099250006', '04023', '서울특별시 강서구 까치산로 150','606호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251007, 'std2025007@green.ac.kr', '윤지원', '2006-07-12', '01010250007', '01099250007', '03781', '서울특별시 종로구 자하문로 75','707호', '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251008, 'std2025008@green.ac.kr', '한승우', '2006-08-25', '01010250008', '01099250008', '06234', '서울특별시 서초구 잠원로 250', '808호', '2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251009, 'std2025009@green.ac.kr', '오연주', '2006-09-07', '01010250009', '01099250009', '04567', '서울특별시 마포구 와우산로 100','909호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251010, 'std2025010@green.ac.kr', '서지훈', '2006-10-18', '01010250010', '01099250010', '05678', '서울특별시 송파구 송파대로 50','1010호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251011, 'std2025011@green.ac.kr', '임수빈', '2006-11-21', '01010250011', '01099250011', '07212', '서울특별시 영등포구 당산로 30','1111호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251012, 'std2025012@green.ac.kr', '조태민', '2006-12-04', '01010250012', '01099250012', '08234', '서울특별시 관악구 낙성대로 200','1212호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251013, 'std2025013@green.ac.kr', '신예나', '2006-01-26', '01010250013', '01099250013', '04023', '서울특별시 강서구 곰달래로 70','1313호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251014, 'std2025014@green.ac.kr', '권민호', '2006-02-13', '01010250014', '01099250014', '03781', '서울특별시 종로구 청계로 12', '1414호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251015, 'std2025015@green.ac.kr', '백서영', '2006-03-09', '01010250015', '01099250015', '06234', '서울특별시 강남구 학원사거리 300','1515호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251016, 'std2025016@green.ac.kr', '문주원', '2006-04-17', '01010250016', '01099250016', '04567', '서울특별시 마포구 토정로 50','1616호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251017, 'std2025017@green.ac.kr', '안유나', '2006-05-28', '01010250017', '01099250017', '05678', '서울특별시 송파구 마천로 90', '1717호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251018, 'std2025018@green.ac.kr', '송재현', '2006-06-11', '01010250018', '01099250018', '07212', '서울특별시 영등포구 양평로 100','1818호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251019, 'std2025019@green.ac.kr', '홍은비', '2006-07-23', '01010250019', '01099250019', '08234', '서울특별시 관악구 청룡로 1500','1919호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251020, 'std2025020@green.ac.kr', '구하준', '2006-08-06', '01010250020', '01099250020', '04023', '서울특별시 강서구 발산로 90', '2020호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251021, 'std2025021@green.ac.kr', '나도윤', '2006-09-19', '01010250021', '01099250021', '06234', '서울특별시 강남구 도산대로 40','2121호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251022, 'std2025022@green.ac.kr', '도채린', '2006-10-02', '01010250022', '01099250022', '04567', '서울특별시 마포구 모래내로 100','2222호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251023, 'std2025023@green.ac.kr', '류시아', '2006-11-15', '01010250023', '01099250023', '05678', '서울특별시 송파구 풍성로 200','2323호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251024, 'std2025024@green.ac.kr', '명재훈', '2006-12-29', '01010250024', '01099250024', '07212', '서울특별시 영등포구 가마산로 60','2424호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
(20251025, 'std2025025@green.ac.kr', '반시현', '2006-01-08', '01010250025', '01099250025', '08234', '서울특별시 관악구 호암로 1500','2525호','2025-03-02', NULL, NULL, '2025-03-02 09:00:00'),
-- 2024학번 25명
(20241001, 'std2024001@green.ac.kr', '강민준', '2005-01-20', '01010240001', '01099240001', '06234', '서울특별시 강남구 영동대로 100','101호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241002, 'std2024002@green.ac.kr', '곽서연', '2005-02-11', '01010240002', '01099240002', '04567', '서울특별시 마포구 노고산로 50','202호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241003, 'std2024003@green.ac.kr', '구지호', '2005-03-04', '01010240003', '01099240003', '05678', '서울특별시 송파구 새말로 30','303호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241004, 'std2024004@green.ac.kr', '권수아', '2005-04-25', '01010240004', '01099240004', '07212', '서울특별시 영등포구 선유로 20','404호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241005, 'std2024005@green.ac.kr', '김건우', '2005-05-16', '01010240005', '01099240005', '08234', '서울특별시 관악구 미성로 88','505호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241006, 'std2024006@green.ac.kr', '나래', '2005-06-09',     '01010240006', '01099240006', '04023', '서울특별시 강서구 화곡로 150','606호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241007, 'std2024007@green.ac.kr', '도하준', '2005-07-22', '01010240007', '01099240007', '03781', '서울특별시 종로구 평창로 75','707호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241008, 'std2024008@green.ac.kr', '문예린', '2005-08-13', '01010240008', '01099240008', '06234', '서울특별시 서초구 방배로 250','808호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241009, 'std2024009@green.ac.kr', '박태양', '2005-09-06', '01010240009', '01099240009', '04567', '서울특별시 마포구 망원로 100','909호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241010, 'std2024010@green.ac.kr', '백지안', '2005-10-27', '01010240010', '01099240010', '05678', '서울특별시 송파구 충민로 50','1010호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241011, 'std2024011@green.ac.kr', '서채원', '2005-11-18', '01010240011', '01099240011', '07212', '서울특별시 영등포구 양산로 30','1111호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241012, 'std2024012@green.ac.kr', '신하민', '2005-12-31', '01010240012', '01099240012', '08234', '서울특별시 관악구 인헌로 200','1212호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241013, 'std2024013@green.ac.kr', '안유찬', '2005-01-12', '01010240013', '01099240013', '04023', '서울특별시 강서구 등촌로 70','1313호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241014, 'std2024014@green.ac.kr', '오시아', '2005-02-23', '01010240014', '01099240014', '03781', '서울특별시 종로구 효자로 12','1414호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241015, 'std2024015@green.ac.kr', '윤선우', '2005-03-14', '01010240015', '01099240015', '06234', '서울특별시 강남구 봉은로 300','1515호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241016, 'std2024016@green.ac.kr', '이가은', '2005-04-05', '01010240016', '01099240016', '04567', '서울특별시 마포구 동교로 50','1616호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241017, 'std2024017@green.ac.kr', '임재훈', '2005-05-26', '01010240017', '01099240017', '05678', '서울특별시 송파구 백제로 90','1717호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241018, 'std2024018@green.ac.kr', '장하늘', '2005-06-17', '01010240018', '01099240018', '07212', '서울특별시 영등포구 국회로 100','1818호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241019, 'std2024019@green.ac.kr', '전지유', '2005-07-08', '01010240019', '01099240019', '08234', '서울특별시 관악구 행운로 1500','1919호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241020, 'std2024020@green.ac.kr', '정도현', '2005-08-29', '01010240020', '01099240020', '04023', '서울특별시 강서구 우장산로 90','2020호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241021, 'std2024021@green.ac.kr', '조윤서', '2005-09-21', '01010240021', '01099240021', '06234', '서울특별시 강남구 청담로 40','2121호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241022, 'std2024022@green.ac.kr', '주민혁', '2005-10-12', '01010240022', '01099240022', '04567', '서울특별시 마포구 성미산로 100','2222호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241023, 'std2024023@green.ac.kr', '진소율', '2005-11-03', '01010240023', '01099240023', '05678', '서울특별시 송파구 둔촌로 200','2323호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241024, 'std2024024@green.ac.kr', '차은우', '2005-12-24', '01010240024', '01099240024', '07212', '서울특별시 영등포구 양평로 60','2424호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
(20241025, 'std2024025@green.ac.kr', '천예솔', '2005-01-15', '01010240025', '01099240025', '08234', '서울특별시 관악구 솔밭로 1500','2525호','2024-03-02', NULL, NULL, '2024-03-02 09:00:00'),
-- 2023학번 20명
(20231001, 'std2023001@green.ac.kr', '하지원', '2004-01-09', '01010230001', '01099230001', '06234', '서울특별시 강남구 도산로 100','101호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231002, 'std2023002@green.ac.kr', '한도윤', '2004-02-20', '01010230002', '01099230002', '04567', '서울특별시 마포구 잔다리로 50','202호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231003, 'std2023003@green.ac.kr', '함채현', '2004-03-11', '01010230003', '01099230003', '05678', '서울특별시 송파구 거여로 30','303호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231004, 'std2023004@green.ac.kr', '허재민', '2004-04-02', '01010230004', '01099230004', '07212', '서울특별시 영등포구 선유서로 20','404호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231005, 'std2023005@green.ac.kr', '홍서영', '2004-05-23', '01010230005', '01099230005', '08234', '서울특별시 관악구 조원로 88','505호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231006, 'std2023006@green.ac.kr', '황지호', '2004-06-14', '01010230006', '01099230006', '04023', '서울특별시 강서구 강서로 150','606호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231007, 'std2023007@green.ac.kr', '곽유준', '2004-07-05', '01010230007', '01099230007', '03781', '서울특별시 종로구 가회로 75','707호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231008, 'std2023008@green.ac.kr', '구나윤', '2004-08-26', '01010230008', '01099230008', '06234', '서울특별시 서초구 서초대로 250','808호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231009, 'std2023009@green.ac.kr', '남시우', '2004-09-17', '01010230009', '01099230009', '04567', '서울특별시 마포구 매봉산로 100','909호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231010, 'std2023010@green.ac.kr', '도예원', '2004-10-08', '01010230010', '01099230010', '05678', '서울특별시 송파구 양재대로 50','1010호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231011, 'std2023011@green.ac.kr', '명우진', '2004-11-29', '01010230011', '01099230011', '07212', '서울특별시 영등포구 도신로 30','1111호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231012, 'std2023012@green.ac.kr', '문하랑', '2004-12-20', '01010230012', '01099230012', '08234', '서울특별시 관악구 보라매로 200','1212호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231013, 'std2023013@green.ac.kr', '반지우', '2004-01-31', '01010230013', '01099230013', '04023', '서울특별시 강서구 양천로 70','1313호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231014, 'std2023014@green.ac.kr', '서태훈', '2004-02-12', '01010230014', '01099230014', '03781', '서울특별시 종로구 자북길 12','1414호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231015, 'std2023015@green.ac.kr', '오지민', '2004-03-23', '01010230015', '01099230015', '06234', '서울특별시 강남구 학동로 300','1515호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231016, 'std2023016@green.ac.kr', '이찬혁', '2004-04-04', '01010230016', '01099230016', '04567', '서울특별시 마포구 와우산로 50','1616호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231017, 'std2023017@green.ac.kr', '장유나', '2004-05-15', '01010230017', '01099230017', '05678', '서울특별시 송파구 가락로 90','1717호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231018, 'std2023018@green.ac.kr', '정현서', '2004-06-26', '01010230018', '01099230018', '07212', '서울특별시 영등포구 의사당로 100','1818호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231019, 'std2023019@green.ac.kr', '주서윤', '2004-07-07', '01010230019', '01099230019', '08234', '서울특별시 관악구 남부순환로 1500','1919호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
(20231020, 'std2023020@green.ac.kr', '진하경', '2004-08-18', '01010230020', '01099230020', '04023', '서울특별시 강서구 마곡로 90','2020호','2023-03-02', NULL, NULL, '2023-03-02 09:00:00'),
-- 2022학번 10명
(20221001, 'std2022001@green.ac.kr', '강현빈', '2003-01-22', '01010220001', '01099220001', '06234', '서울특별시 강남구 봉은사로 100','101호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221002, 'std2022002@green.ac.kr', '김지민', '2003-02-13', '01010220002', '01099220002', '04567', '서울특별시 마포구 신촌로 50','202호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221003, 'std2022003@green.ac.kr', '나서준', '2003-03-04', '01010220003', '01099220003', '05678', '서울특별시 송파구 잠실로 30','303호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221004, 'std2022004@green.ac.kr', '도연재', '2003-04-25', '01010220004', '01099220004', '07212', '서울특별시 영등포구 신길로 20','404호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221005, 'std2022005@green.ac.kr', '문성호', '2003-05-16', '01010220005', '01099220005', '08234', '서울특별시 관악구 신원로 88','505호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221006, 'std2022006@green.ac.kr', '박혜린', '2003-06-07', '01010220006', '01099220006', '04023', '서울특별시 강서구 까치산로 150','606호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221007, 'std2022007@green.ac.kr', '서현우', '2003-07-28', '01010220007', '01099220007', '03781', '서울특별시 종로구 자하문로 75','707호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221008, 'std2022008@green.ac.kr', '이태리', '2003-08-19', '01010220008', '01099220008', '06234', '서울특별시 서초구 잠원로 250','808호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221009, 'std2022009@green.ac.kr', '정유빈', '2003-09-10', '01010220009', '01099220009', '04567', '서울특별시 마포구 와우산로 100','909호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00'),
(20221010, 'std2022010@green.ac.kr', '한지우', '2003-10-21', '01010220010', '01099220010', '05678', '서울특별시 송파구 송파대로 50','1010호','2022-03-02', NULL, NULL, '2022-03-02 09:00:00');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 10. 관리자 (admin) - 모두 재직
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO admin (member_code, status) VALUES
                                            (20203001, 'EMPLOYMENT'), (20223001, 'EMPLOYMENT'), (20253001, 'EMPLOYMENT');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 11. 교수 (professor) - 규칙 5번대 모두 적용
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO professor (member_code, major_id, degree, position, lab_building, lab_room, lab_tel, status) VALUES
                                                                                               (20002001, 401, 'DOCTOR', '전임교수', '공학관',  '공학관 410호', '02-1234-4101', 'EMPLOYMENT'),
                                                                                               (20052001, 102, 'DOCTOR', '전임교수', '인문관',  '인문관 110호', '02-1234-1101', 'EMPLOYMENT'),
                                                                                               (20082001, 402, 'DOCTOR', '전임교수', '공학관',  '공학관 420호', '02-1234-4201', 'EMPLOYMENT'),
                                                                                               (20102001, 201, 'DOCTOR', '조교수', '자연과학관', '자연관 210호', '02-1234-2101', 'EMPLOYMENT'),
                                                                                               (20122001, 202, 'DOCTOR', '조교수', '자연과학관',  '자연관 220호', '02-1234-2201', 'EMPLOYMENT'),
                                                                                               (20132001, 601, 'DOCTOR', '조교수', '경영관',    '경영관 620호', '02-1234-6201', 'EMPLOYMENT'),
                                                                                               (20152001, 601, 'MASTER', '시간강사', '경영관',  '경영관 610호', '02-1234-6101', 'EMPLOYMENT'),
                                                                                               (20172001, 401, 'DOCTOR', '전임교수', '공학관',  '공학관 411호', '02-1234-4102', 'EMPLOYMENT'),
                                                                                               (20182001, 101, 'MASTER', '시간강사', '인문관',  '인문관 111호', '02-1234-1102', 'EMPLOYMENT'),
                                                                                               (20202001, 301, 'DOCTOR', '명예교수', '사회과학관', '사회관 310호', '02-1234-3101', 'ABSENCE');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 12. 학생 (student) - 학적상태 다양화 (ENROLLED 85, ABSENCE 8, GRADUATION 3, EXPULSION 1, QUIT 1, UNREGISTERED 2)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO student (member_code, academic_year, semester, status, is_transfer, is_multi_child, is_veteran, updated_at) VALUES
-- 2026학번 (1학년) 20명 - 모두 재학
(20261001,1,1,'ENROLLED',FALSE,FALSE,FALSE, NULL),(20261002,1,1,'ENROLLED',FALSE,FALSE,FALSE, NULL),(20261003,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261004,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261005,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20261006,1,1,'ENROLLED',FALSE,TRUE,FALSE,NULL),(20261007,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261008,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261009,1,1,'ENROLLED',FALSE,FALSE,TRUE,NULL),(20261010,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20261011,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261012,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261013,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261014,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261015,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20261016,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261017,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261018,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261019,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20261020,1,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
-- 2025학번 (2학년) 25명 - 23재학, 1휴학, 1미등록
(20251001,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251002,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251003,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251004,2,1,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20251005,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20251006,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251007,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251008,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251009,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251010,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20251011,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251012,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251013,2,1,'ENROLLED',FALSE,TRUE,FALSE,NULL),(20251014,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251015,2,1,'UNREGISTERED',FALSE,FALSE,FALSE,NULL),
(20251016,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251017,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251018,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251019,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251020,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20251021,2,1,'ENROLLED',TRUE,FALSE,FALSE,NULL),(20251022,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251023,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251024,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20251025,2,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
-- 2024학번 (3학년) 25명 - 22재학, 2휴학, 1자퇴
(20241001,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241002,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241003,3,1,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20241004,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241005,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20241006,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241007,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241008,3,1,'ENROLLED',FALSE,TRUE,FALSE,NULL),(20241009,3,1,'ENROLLED',FALSE,FALSE,TRUE,NULL),(20241010,3,1,'QUIT',FALSE,FALSE,FALSE,NULL),
(20241011,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241012,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241013,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241014,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241015,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20241016,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241017,3,1,'ENROLLED',TRUE,FALSE,FALSE,NULL),(20241018,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241019,3,1,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20241020,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20241021,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241022,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241023,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241024,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20241025,3,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
-- 2023학번 (4학년) 20명 - 16재학, 2휴학, 1퇴학, 1미등록
(20231001,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231002,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231003,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231004,4,1,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20231005,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20231006,4,1,'ENROLLED',FALSE,TRUE,FALSE,NULL),(20231007,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231008,4,1,'EXPULSION',FALSE,FALSE,FALSE,NULL),(20231009,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231010,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20231011,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231012,4,1,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20231013,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231014,4,1,'ENROLLED',TRUE,FALSE,FALSE,NULL),(20231015,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),
(20231016,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231017,4,1,'UNREGISTERED',FALSE,FALSE,FALSE,NULL),(20231018,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231019,4,1,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20231020,4,1,'ENROLLED',FALSE,FALSE,TRUE,NULL),
-- 2022학번 (졸업/초과) 10명 - 4재학, 3휴학, 3졸업
(20221001,4,2,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20221002,4,2,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20221003,4,2,'GRADUATION',FALSE,FALSE,FALSE,NULL),(20221004,4,2,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20221005,4,2,'GRADUATION',FALSE,FALSE,FALSE,NULL),
(20221006,4,2,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20221007,4,2,'ENROLLED',FALSE,FALSE,FALSE,NULL),(20221008,4,2,'GRADUATION',FALSE,FALSE,FALSE,NULL),(20221009,4,2,'ABSENCE',FALSE,FALSE,FALSE,NULL),(20221010,4,2,'ENROLLED',FALSE,FALSE,FALSE,NULL);


-- [PART 5/6] gu_member 학생 전공 + gu_core 캐시 + 학과장 매핑
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 13. 학생 전공 (student_major) - 학과별 균등 분포
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_member;

INSERT INTO student_major (student_major_id, student_code, major_id, type, is_active, created_at) VALUES
-- 2026학번
(4001, 20261001, 401, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4002, 20261002, 102, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4003, 20261003, 601, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4004, 20261004, 301, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4005, 20261005, 201, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4006, 20261006, 402, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4007, 20261007, 101, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4008, 20261008, 202, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4009, 20261009, 401, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4010, 20261010, 102, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4011, 20261011, 601, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4012, 20261012, 301, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4013, 20261013, 201, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4014, 20261014, 402, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4015, 20261015, 101, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4016, 20261016, 202, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4017, 20261017, 401, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4018, 20261018, 102, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4019, 20261019, 601, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
(4020, 20261020, 301, 'PRIMARY', TRUE, '2026-03-02 09:00:00'),
-- 2025학번
(4021, 20251001, 401, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4022, 20251002, 102, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4023, 20251003, 601, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4024, 20251004, 301, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4025, 20251005, 201, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4026, 20251006, 402, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4027, 20251007, 101, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4028, 20251008, 202, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4029, 20251009, 401, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4030, 20251010, 102, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4031, 20251011, 601, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4032, 20251012, 301, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4033, 20251013, 201, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4034, 20251014, 402, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4035, 20251015, 101, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4036, 20251016, 202, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4037, 20251017, 401, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4038, 20251018, 102, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4039, 20251019, 601, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4040, 20251020, 301, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4041, 20251021, 201, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4042, 20251022, 402, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4043, 20251023, 101, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4044, 20251024, 202, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
(4045, 20251025, 401, 'PRIMARY', TRUE, '2025-03-02 09:00:00'),
-- 2024학번
(4046, 20241001, 401, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4047, 20241002, 102, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4048, 20241003, 601, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4049, 20241004, 301, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4050, 20241005, 201, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4051, 20241006, 402, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4052, 20241007, 101, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4053, 20241008, 202, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4054, 20241009, 401, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4055, 20241010, 102, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4056, 20241011, 601, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4057, 20241012, 301, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4058, 20241013, 201, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4059, 20241014, 402, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4060, 20241015, 101, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4061, 20241016, 202, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4062, 20241017, 401, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4063, 20241018, 102, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4064, 20241019, 601, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4065, 20241020, 301, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4066, 20241021, 201, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4067, 20241022, 402, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4068, 20241023, 101, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4069, 20241024, 202, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
(4070, 20241025, 401, 'PRIMARY', TRUE, '2024-03-02 09:00:00'),
-- 2023학번
(4071, 20231001, 401, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4072, 20231002, 102, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4073, 20231003, 601, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4074, 20231004, 301, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4075, 20231005, 201, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4076, 20231006, 402, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4077, 20231007, 101, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4078, 20231008, 202, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4079, 20231009, 401, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4080, 20231010, 102, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4081, 20231011, 601, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4082, 20231012, 301, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4083, 20231013, 201, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4084, 20231014, 402, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4085, 20231015, 101, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4086, 20231016, 202, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4087, 20231017, 401, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4088, 20231018, 102, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4089, 20231019, 601, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
(4090, 20231020, 301, 'PRIMARY', TRUE, '2023-03-02 09:00:00'),
-- 2022학번
(4091, 20221001, 401, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4092, 20221002, 102, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4093, 20221003, 601, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4094, 20221004, 301, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4095, 20221005, 201, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4096, 20221006, 402, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4097, 20221007, 101, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4098, 20221008, 202, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4099, 20221009, 401, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
(4100, 20221010, 102, 'PRIMARY', TRUE, '2022-03-02 09:00:00'),
-- 복수전공/부전공
(4101, 20231014, 601, 'DOUBLE', TRUE, '2024-09-01 09:00:00'),
(4102, 20221001, 201, 'MINOR',  TRUE, '2024-09-01 09:00:00');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 14. 캐시 동기화 (gu_core)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_core;

-- 14-1. 교수 캐시
INSERT INTO professor_cache (member_code, name, degree, status) VALUES
                                                                    (20002001,'정교수','DOCTOR','EMPLOYMENT'),(20052001,'김지혜','DOCTOR','EMPLOYMENT'),(20082001,'장현석','DOCTOR','EMPLOYMENT'),
                                                                    (20102001,'이상민','DOCTOR','EMPLOYMENT'),(20122001,'오수진','DOCTOR','EMPLOYMENT'),(20132001,'신미래','DOCTOR','EMPLOYMENT'),
                                                                    (20152001,'박철수','MASTER','EMPLOYMENT'),(20172001,'문지현','DOCTOR','EMPLOYMENT'),(20182001,'류성호','MASTER','EMPLOYMENT'),
                                                                    (20202001,'최영희','DOCTOR','ABSENCE');

-- 14-2. 학생 캐시 (전체 100명)
INSERT INTO student_cache (member_code, name, email, academic_year, semester, status, is_transfer, is_multi_child, is_veteran) VALUES
-- 2026학번
(20261001,'김민준','std2026001@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261002,'이서연','std2026002@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261003,'박지호','std2026003@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261004,'정수아','std2026004@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261005,'최건우','std2026005@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),
(20261006,'강나래','std2026006@green.ac.kr',1,1,'ENROLLED',FALSE,TRUE,FALSE),(20261007,'윤도하','std2026007@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261008,'한예린','std2026008@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261009,'오태양','std2026009@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,TRUE),(20261010,'서지안','std2026010@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),
(20261011,'임채원','std2026011@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261012,'조하민','std2026012@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261013,'신유찬','std2026013@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261014,'권시아','std2026014@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261015,'백선우','std2026015@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),
(20261016,'문가은','std2026016@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261017,'안재훈','std2026017@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261018,'송하늘','std2026018@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261019,'홍지유','std2026019@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),(20261020,'구도현','std2026020@green.ac.kr',1,1,'ENROLLED',FALSE,FALSE,FALSE),
-- 2025학번
(20251001,'김도현','std2025001@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251002,'이가영','std2025002@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251003,'박서준','std2025003@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251004,'정유진','std2025004@green.ac.kr',2,1,'ABSENCE',FALSE,FALSE,FALSE),(20251005,'최민서','std2025005@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),
(20251006,'강하윤','std2025006@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251007,'윤지원','std2025007@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251008,'한승우','std2025008@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251009,'오연주','std2025009@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251010,'서지훈','std2025010@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),
(20251011,'임수빈','std2025011@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251012,'조태민','std2025012@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251013,'신예나','std2025013@green.ac.kr',2,1,'ENROLLED',FALSE,TRUE,FALSE),(20251014,'권민호','std2025014@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251015,'백서영','std2025015@green.ac.kr',2,1,'UNREGISTERED',FALSE,FALSE,FALSE),
(20251016,'문주원','std2025016@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251017,'안유나','std2025017@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251018,'송재현','std2025018@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251019,'홍은비','std2025019@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251020,'구하준','std2025020@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),
(20251021,'나도윤','std2025021@green.ac.kr',2,1,'ENROLLED',TRUE,FALSE,FALSE),(20251022,'도채린','std2025022@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251023,'류시아','std2025023@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251024,'명재훈','std2025024@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),(20251025,'반시현','std2025025@green.ac.kr',2,1,'ENROLLED',FALSE,FALSE,FALSE),
-- 2024학번
(20241001,'강민준','std2024001@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241002,'곽서연','std2024002@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241003,'구지호','std2024003@green.ac.kr',3,1,'ABSENCE',FALSE,FALSE,FALSE),(20241004,'권수아','std2024004@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241005,'김건우','std2024005@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),
(20241006,'나래','std2024006@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241007,'도하준','std2024007@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241008,'문예린','std2024008@green.ac.kr',3,1,'ENROLLED',FALSE,TRUE,FALSE),(20241009,'박태양','std2024009@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,TRUE),(20241010,'백지안','std2024010@green.ac.kr',3,1,'QUIT',FALSE,FALSE,FALSE),
(20241011,'서채원','std2024011@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241012,'신하민','std2024012@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241013,'안유찬','std2024013@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241014,'오시아','std2024014@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241015,'윤선우','std2024015@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),
(20241016,'이가은','std2024016@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241017,'임재훈','std2024017@green.ac.kr',3,1,'ENROLLED',TRUE,FALSE,FALSE),(20241018,'장하늘','std2024018@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241019,'전지유','std2024019@green.ac.kr',3,1,'ABSENCE',FALSE,FALSE,FALSE),(20241020,'정도현','std2024020@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),
(20241021,'조윤서','std2024021@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241022,'주민혁','std2024022@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241023,'진소율','std2024023@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241024,'차은우','std2024024@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),(20241025,'천예솔','std2024025@green.ac.kr',3,1,'ENROLLED',FALSE,FALSE,FALSE),
-- 2023학번
(20231001,'하지원','std2023001@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231002,'한도윤','std2023002@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231003,'함채현','std2023003@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231004,'허재민','std2023004@green.ac.kr',4,1,'ABSENCE',FALSE,FALSE,FALSE),(20231005,'홍서영','std2023005@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),
(20231006,'황지호','std2023006@green.ac.kr',4,1,'ENROLLED',FALSE,TRUE,FALSE),(20231007,'곽유준','std2023007@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231008,'구나윤','std2023008@green.ac.kr',4,1,'EXPULSION',FALSE,FALSE,FALSE),(20231009,'남시우','std2023009@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231010,'도예원','std2023010@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),
(20231011,'명우진','std2023011@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231012,'문하랑','std2023012@green.ac.kr',4,1,'ABSENCE',FALSE,FALSE,FALSE),(20231013,'반지우','std2023013@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231014,'서태훈','std2023014@green.ac.kr',4,1,'ENROLLED',TRUE,FALSE,FALSE),(20231015,'오지민','std2023015@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),
(20231016,'이찬혁','std2023016@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231017,'장유나','std2023017@green.ac.kr',4,1,'UNREGISTERED',FALSE,FALSE,FALSE),(20231018,'정현서','std2023018@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231019,'주서윤','std2023019@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,FALSE),(20231020,'진하경','std2023020@green.ac.kr',4,1,'ENROLLED',FALSE,FALSE,TRUE),
-- 2022학번
(20221001,'강현빈','std2022001@green.ac.kr',4,2,'ENROLLED',FALSE,FALSE,FALSE),(20221002,'김지민','std2022002@green.ac.kr',4,2,'ABSENCE',FALSE,FALSE,FALSE),(20221003,'나서준','std2022003@green.ac.kr',4,2,'GRADUATION',FALSE,FALSE,FALSE),(20221004,'도연재','std2022004@green.ac.kr',4,2,'ENROLLED',FALSE,FALSE,FALSE),(20221005,'문성호','std2022005@green.ac.kr',4,2,'GRADUATION',FALSE,FALSE,FALSE),
(20221006,'박혜린','std2022006@green.ac.kr',4,2,'ABSENCE',FALSE,FALSE,FALSE),(20221007,'서현우','std2022007@green.ac.kr',4,2,'ENROLLED',FALSE,FALSE,FALSE),(20221008,'이태리','std2022008@green.ac.kr',4,2,'GRADUATION',FALSE,FALSE,FALSE),(20221009,'정유빈','std2022009@green.ac.kr',4,2,'ABSENCE',FALSE,FALSE,FALSE),(20221010,'한지우','std2022010@green.ac.kr',4,2,'ENROLLED',FALSE,FALSE,FALSE);

-- 14-3. major UPDATE — 학과장 매핑
UPDATE major SET professor_code = 20002001 WHERE major_id = 401;
UPDATE major SET professor_code = 20052001 WHERE major_id = 102;
UPDATE major SET professor_code = 20082001 WHERE major_id = 402;
UPDATE major SET professor_code = 20102001 WHERE major_id = 201;
UPDATE major SET professor_code = 20122001 WHERE major_id = 202;
UPDATE major SET professor_code = 20132001 WHERE major_id = 601;
UPDATE major SET professor_code = 20182001 WHERE major_id = 101;
UPDATE major SET professor_code = 20202001 WHERE major_id = 301;


-- [PART 6-A] 강의 50개 (lecture)
USE my_gu_core;

-- 14-4. 학생 전공 캐시 (student_major_cache)
INSERT INTO student_major_cache (student_major_id, student_code, major_id, type, is_active) VALUES
-- 2026학번
(4001, 20261001, 401, 'PRIMARY', TRUE),
(4002, 20261002, 102, 'PRIMARY', TRUE),
(4003, 20261003, 601, 'PRIMARY', TRUE),
(4004, 20261004, 301, 'PRIMARY', TRUE),
(4005, 20261005, 201, 'PRIMARY', TRUE),
(4006, 20261006, 402, 'PRIMARY', TRUE),
(4007, 20261007, 101, 'PRIMARY', TRUE),
(4008, 20261008, 202, 'PRIMARY', TRUE),
(4009, 20261009, 401, 'PRIMARY', TRUE),
(4010, 20261010, 102, 'PRIMARY', TRUE),
(4011, 20261011, 601, 'PRIMARY', TRUE),
(4012, 20261012, 301, 'PRIMARY', TRUE),
(4013, 20261013, 201, 'PRIMARY', TRUE),
(4014, 20261014, 402, 'PRIMARY', TRUE),
(4015, 20261015, 101, 'PRIMARY', TRUE),
(4016, 20261016, 202, 'PRIMARY', TRUE),
(4017, 20261017, 401, 'PRIMARY', TRUE),
(4018, 20261018, 102, 'PRIMARY', TRUE),
(4019, 20261019, 601, 'PRIMARY', TRUE),
(4020, 20261020, 301, 'PRIMARY', TRUE),
-- 2025학번
(4021, 20251001, 401, 'PRIMARY', TRUE),(4022, 20251002, 102, 'PRIMARY', TRUE),(4023, 20251003, 601, 'PRIMARY', TRUE),
(4024, 20251004, 301, 'PRIMARY', TRUE),(4025, 20251005, 201, 'PRIMARY', TRUE),(4026, 20251006, 402, 'PRIMARY', TRUE),
(4027, 20251007, 101, 'PRIMARY', TRUE),(4028, 20251008, 202, 'PRIMARY', TRUE),(4029, 20251009, 401, 'PRIMARY', TRUE),
(4030, 20251010, 102, 'PRIMARY', TRUE),(4031, 20251011, 601, 'PRIMARY', TRUE),(4032, 20251012, 301, 'PRIMARY', TRUE),
(4033, 20251013, 201, 'PRIMARY', TRUE),(4034, 20251014, 402, 'PRIMARY', TRUE),(4035, 20251015, 101, 'PRIMARY', TRUE),
(4036, 20251016, 202, 'PRIMARY', TRUE),(4037, 20251017, 401, 'PRIMARY', TRUE),(4038, 20251018, 102, 'PRIMARY', TRUE),
(4039, 20251019, 601, 'PRIMARY', TRUE),(4040, 20251020, 301, 'PRIMARY', TRUE),(4041, 20251021, 201, 'PRIMARY', TRUE),
(4042, 20251022, 402, 'PRIMARY', TRUE),(4043, 20251023, 101, 'PRIMARY', TRUE),(4044, 20251024, 202, 'PRIMARY', TRUE),
(4045, 20251025, 401, 'PRIMARY', TRUE),
-- 2024학번
(4046, 20241001, 401, 'PRIMARY', TRUE),(4047, 20241002, 102, 'PRIMARY', TRUE),(4048, 20241003, 601, 'PRIMARY', TRUE),
(4049, 20241004, 301, 'PRIMARY', TRUE),(4050, 20241005, 201, 'PRIMARY', TRUE),(4051, 20241006, 402, 'PRIMARY', TRUE),
(4052, 20241007, 101, 'PRIMARY', TRUE),(4053, 20241008, 202, 'PRIMARY', TRUE),(4054, 20241009, 401, 'PRIMARY', TRUE),
(4055, 20241010, 102, 'PRIMARY', TRUE),(4056, 20241011, 601, 'PRIMARY', TRUE),(4057, 20241012, 301, 'PRIMARY', TRUE),
(4058, 20241013, 201, 'PRIMARY', TRUE),(4059, 20241014, 402, 'PRIMARY', TRUE),(4060, 20241015, 101, 'PRIMARY', TRUE),
(4061, 20241016, 202, 'PRIMARY', TRUE),(4062, 20241017, 401, 'PRIMARY', TRUE),(4063, 20241018, 102, 'PRIMARY', TRUE),
(4064, 20241019, 601, 'PRIMARY', TRUE),(4065, 20241020, 301, 'PRIMARY', TRUE),(4066, 20241021, 201, 'PRIMARY', TRUE),
(4067, 20241022, 402, 'PRIMARY', TRUE),(4068, 20241023, 101, 'PRIMARY', TRUE),(4069, 20241024, 202, 'PRIMARY', TRUE),
(4070, 20241025, 401, 'PRIMARY', TRUE),
-- 2023학번
(4071, 20231001, 401, 'PRIMARY', TRUE),(4072, 20231002, 102, 'PRIMARY', TRUE),(4073, 20231003, 601, 'PRIMARY', TRUE),
(4074, 20231004, 301, 'PRIMARY', TRUE),(4075, 20231005, 201, 'PRIMARY', TRUE),(4076, 20231006, 402, 'PRIMARY', TRUE),
(4077, 20231007, 101, 'PRIMARY', TRUE),(4078, 20231008, 202, 'PRIMARY', TRUE),(4079, 20231009, 401, 'PRIMARY', TRUE),
(4080, 20231010, 102, 'PRIMARY', TRUE),(4081, 20231011, 601, 'PRIMARY', TRUE),(4082, 20231012, 301, 'PRIMARY', TRUE),
(4083, 20231013, 201, 'PRIMARY', TRUE),(4084, 20231014, 402, 'PRIMARY', TRUE),(4085, 20231015, 101, 'PRIMARY', TRUE),
(4086, 20231016, 202, 'PRIMARY', TRUE),(4087, 20231017, 401, 'PRIMARY', TRUE),(4088, 20231018, 102, 'PRIMARY', TRUE),
(4089, 20231019, 601, 'PRIMARY', TRUE),(4090, 20231020, 301, 'PRIMARY', TRUE),
-- 2022학번
(4091, 20221001, 401, 'PRIMARY', TRUE),(4092, 20221002, 102, 'PRIMARY', TRUE),(4093, 20221003, 601, 'PRIMARY', TRUE),
(4094, 20221004, 301, 'PRIMARY', TRUE),(4095, 20221005, 201, 'PRIMARY', TRUE),(4096, 20221006, 402, 'PRIMARY', TRUE),
(4097, 20221007, 101, 'PRIMARY', TRUE),(4098, 20221008, 202, 'PRIMARY', TRUE),(4099, 20221009, 401, 'PRIMARY', TRUE),
(4100, 20221010, 102, 'PRIMARY', TRUE),
-- 복수전공/부전공
(4101, 20231014, 601, 'DOUBLE', TRUE),
(4102, 20221001, 201, 'MINOR',  TRUE);


-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 15. 강의 (lecture) 50개
-- 규칙 9번: 4개 lecture_type 사용
-- 규칙 9-2: 2024~2026년 / 9-3: 1,2학기 / 9-4: 1,2,3학점
-- 규칙 9-1: PENDING/APPROVED/REJECTED 다양화
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- 컴퓨터공학과 (401) - 정교수, 문지현
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5001, 20002001, 401, 2026, 1, '프로그래밍기초', 3, 'MAJOR_REQUIRED', '홍길동, 파이썬 프로그래밍, 한빛미디어', '프로그래밍의 기본 개념과 논리적 사고를 익혀 간단한 프로그램을 작성할 수 있다.', '1주:강의소개, 2주:변수와자료형, 3주:조건문, 4주:반복문, 5주:함수, 6주:리스트, 7주:중간고사, 8주:클래스, 9주:파일입출력, 10주:예외처리, 11주:라이브러리, 12주:프로젝트I, 13주:프로젝트II, 14주:발표, 15주:기말고사', 1, 35, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5002, 20002001, 401, 2026, 1, '자료구조', 3, 'MAJOR_REQUIRED', '이기정, 자료구조와 알고리즘, 생능출판사', '배열, 스택, 큐, 트리 등 핵심 자료구조를 이해하고 구현할 수 있다.', '1주:강의소개, 2주:배열, 3주:연결리스트, 4주:스택, 5주:큐, 6주:트리, 7주:중간고사, 8주:이진탐색트리, 9주:힙, 10주:해시, 11주:그래프, 12주:정렬, 13주:탐색, 14주:복습, 15주:기말고사', 2, 35, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5003, 20002001, 401, 2026, 1, '운영체제', 3, 'MAJOR_REQUIRED', '공룡책팀, 운영체제: 내부구조, Pearson', '프로세스, 메모리, 파일 시스템 등 운영체제 핵심 개념을 학습한다.', '1주:OS개요, 2주:프로세스, 3주:스레드, 4주:CPU스케줄링, 5주:동기화, 6주:교착상태, 7주:중간고사, 8주:메모리관리, 9주:가상메모리, 10주:파일시스템, 11주:입출력, 12주:보안, 13주:분산, 14주:복습, 15주:기말고사', 3, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5004, 20172001, 401, 2026, 1, '알고리즘', 3, 'MAJOR_REQUIRED', '문병로, 쉽게 배우는 알고리즘, 한빛미디어', '다양한 알고리즘 설계 기법을 학습하고 문제에 적용한다.', '1주:복잡도, 2주:분할정복, 3주:DP, 4주:탐욕, 5주:백트래킹, 6주:그래프, 7주:중간고사, 8주:최단경로, 9주:MST, 10주:네트워크플로우, 11주:문자열, 12주:근사, 13주:실습, 14주:복습, 15주:기말고사', 2, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5005, 20172001, 401, 2026, 1, '데이터베이스', 3, 'MAJOR_REQUIRED', '이한빛, 데이터베이스 개론, 한빛아카데미', '관계형 데이터베이스 설계와 SQL 활용 능력을 기른다.', '1주:DB개요, 2주:관계형모델, 3주:SQL기초, 4주:SQL심화, 5주:ERD, 6주:정규화, 7주:중간고사, 8주:인덱스, 9주:트랜잭션, 10주:동시성, 11주:회복, 12주:NoSQL, 13주:실습, 14주:복습, 15주:기말고사', 3, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5006, 20002001, 401, 2026, 1, '컴퓨터구조', 3, 'MAJOR_ELECTIVE', 'Patterson, Computer Organization, Morgan Kaufmann', 'CPU, 메모리, 입출력 등 컴퓨터 시스템 구조를 이해한다.', '1주:디지털논리, 2주:데이터표현, 3주:CPU구조, 4주:명령어, 5주:파이프라이닝, 6주:캐시, 7주:중간고사, 8주:메모리계층, 9주:가상메모리, 10주:I/O, 11주:병렬처리, 12주:실습, 13주:최신트렌드, 14주:복습, 15주:기말고사', 3, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5007, 20172001, 401, 2026, 1, '소프트웨어공학', 3, 'MAJOR_ELECTIVE', '이상구, 소프트웨어공학, 정보문화사', 'SW 개발 생명주기와 팀 프로젝트 관리 역량을 키운다.', '1주:SW공학개요, 2주:요구공학, 3주:설계, 4주:UML, 5주:아키텍처, 6주:애자일, 7주:중간고사, 8주:테스팅, 9주:형상관리, 10주:프로젝트관리, 11주:팀프로젝트I, 12주:팀프로젝트II, 13주:발표, 14주:복습, 15주:기말고사', 4, 25, 'PENDING', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-02-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5008, 20172001, 401, 2026, 1, '캡스톤디자인', 3, 'MAJOR_REQUIRED', '담당교수 배포 자료', '전공 지식을 종합한 팀 프로젝트로 실제 SW 시스템을 설계·구현한다.', '1주:OT, 2주:팀구성, 3주:요구사항, 4주:설계, 5주:DB설계, 6주:환경구축, 7주:중간발표, 8주:백엔드I, 9주:백엔드II, 10주:프론트I, 11주:프론트II, 12주:통합, 13주:발표준비, 14주:최종발표, 15주:보고서', 4, 20, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5009, 20002001, 401, 2025, 2, '인공지능개론', 3, 'MAJOR_ELECTIVE', 'Russell & Norvig, AI, Pearson', 'AI 기본 개념과 머신러닝 알고리즘을 이해한다.', '1주:AI개요, 2주:탐색, 3주:지식표현, 4주:ML개론, 5주:회귀, 6주:분류, 7주:중간고사, 8주:신경망, 9주:딥러닝, 10주:CNN, 11주:NLP, 12주:강화학습, 13주:AI윤리, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5010, 20172001, 401, 2025, 2, '웹프로그래밍', 3, 'MAJOR_ELECTIVE', 'Jon Duckett, HTML & CSS, Wiley', 'HTML/CSS/JS와 백엔드 기초를 학습한다.', '1주:웹개요, 2주:HTML, 3주:CSS, 4주:CSS심화, 5주:JS기초, 6주:DOM, 7주:중간고사, 8주:AJAX, 9주:React, 10주:백엔드, 11주:Node.js, 12주:REST, 13주:프로젝트, 14주:복습, 15주:기말고사', 2, 30, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL);

-- 영어영문학과 (102) - 김지혜
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5011, 20052001, 102, 2026, 1, '영어회화', 2, 'MAJOR_REQUIRED', 'Murphy, English Grammar in Use, Cambridge', '일상 및 학문적 상황에서 영어 의사소통 능력을 키운다.', '1주:자기소개, 2주:일상표현, 3주:의견말하기, 4주:토론, 5주:발표, 6주:중간발표, 7주:중간고사, 8주:학문영어, 9주:인터뷰, 10주:프레젠테이션, 11주:뉴스영어, 12주:토론심화, 13주:최종발표, 14주:복습, 15주:기말고사', 1, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5012, 20052001, 102, 2026, 1, '영문법', 3, 'MAJOR_REQUIRED', 'Swan, Practical English Usage, Oxford', '영어 문법 체계를 이해하고 독해와 작문에 활용한다.', '1주:문법개요, 2주:품사, 3주:문장구조, 4주:시제, 5주:조동사, 6주:수동태, 7주:중간고사, 8주:가정법, 9주:관계사, 10주:접속사, 11주:비교, 12주:특수구문, 13주:응용, 14주:복습, 15주:기말고사', 1, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5013, 20052001, 102, 2026, 1, '영어독해', 3, 'MAJOR_REQUIRED', 'Pauk, How to Study in College, Cengage', '다양한 영어 텍스트를 정확하게 이해한다.', '1주:독해전략, 2주:주제파악, 3주:세부정보, 4주:추론, 5주:어휘, 6주:신문, 7주:중간고사, 8주:학술, 9주:논설문, 10주:서사문, 11주:요약, 12주:비판적읽기, 13주:실전, 14주:복습, 15주:기말고사', 2, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5014, 20052001, 102, 2026, 1, '셰익스피어문학', 3, 'MAJOR_ELECTIVE', 'Wells, Shakespeare, Oxford', '셰익스피어 작품을 읽고 시대적 맥락을 분석한다.', '1주:생애, 2주:소네트, 3주:한여름밤의꿈, 4주:오셀로, 5주:햄릿I, 6주:햄릿II, 7주:중간고사, 8주:맥베스, 9주:리어왕, 10주:로미오와줄리엣, 11주:베니스의상인, 12주:분석, 13주:발표, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5015, 20052001, 102, 2026, 1, '영어교양', 2, 'GENERAL_ELECTIVE', '담당교수 배포 자료', '교양 수준의 영어 표현력을 향상시킨다.', '1주:OT, 2주:발음, 3주:기본회화, 4주:여행영어, 5주:업무영어, 6주:문화영어, 7주:중간평가, 8주:리스닝, 9주:라이팅기초, 10주:이메일, 11주:발표연습, 12주:토론, 13주:최종발표, 14주:복습, 15주:기말평가', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5016, 20052001, 102, 2025, 2, '영문학개론', 3, 'MAJOR_ELECTIVE', 'Abrams, A Glossary of Literary Terms, Cengage', '영문학의 주요 장르와 문학사 흐름을 이해한다.', '1주:문학이란, 2주:시, 3주:소설, 4주:희곡, 5주:르네상스, 6주:낭만주의, 7주:중간고사, 8주:빅토리아, 9주:모더니즘, 10주:포스트모더니즘, 11주:미국문학, 12주:분석실습, 13주:발표, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL);

-- 수학과 (201) - 이상민
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5017, 20102001, 201, 2026, 1, '미적분학', 3, 'MAJOR_REQUIRED', 'Stewart, Calculus, Cengage', '극한, 미분, 적분 개념을 이해하고 응용한다.', '1주:극한, 2주:연속성, 3주:미분, 4주:미분법칙, 5주:연쇄법칙, 6주:응용, 7주:중간고사, 8주:적분, 9주:적분법칙, 10주:치환, 11주:부분적분, 12주:이상적분, 13주:급수, 14주:복습, 15주:기말고사', 1, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5018, 20102001, 201, 2026, 1, '선형대수', 3, 'MAJOR_REQUIRED', 'Lay, Linear Algebra, Pearson', '벡터 공간, 행렬, 고유값 등 선형대수 개념을 학습한다.', '1주:선형방정식, 2주:행렬, 3주:역행렬, 4주:행렬식, 5주:벡터공간, 6주:기저, 7주:중간고사, 8주:선형변환, 9주:고유값, 10주:직교화, 11주:최소제곱, 12주:응용, 13주:실습, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5019, 20102001, 201, 2026, 1, '확률과통계', 3, 'MAJOR_REQUIRED', 'Walpole, Probability & Statistics, Pearson', '확률 개념과 통계적 추론을 학습한다.', '1주:확률, 2주:조건부확률, 3주:이산분포, 4주:연속분포, 5주:정규분포, 6주:기댓값, 7주:중간고사, 8주:표본분포, 9주:추정, 10주:가설검정, 11주:회귀, 12주:분산분석, 13주:실습, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5020, 20102001, 201, 2026, 1, '수리통계학', 3, 'MAJOR_ELECTIVE', 'Hogg, Mathematical Statistics, Pearson', '통계 이론의 수학적 기반을 학습한다.', '1주:확률공간, 2주:확률변수, 3주:분포함수, 4주:다변량, 5주:조건부, 6주:변환, 7주:중간고사, 8주:순서통계량, 9주:충분통계량, 10주:최대우도, 11주:검정이론, 12주:베이즈, 13주:비모수, 14주:복습, 15주:기말고사', 3, 20, 'PENDING', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-02-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5021, 20102001, 201, 2025, 2, '해석학', 3, 'MAJOR_REQUIRED', 'Rudin, Mathematical Analysis, McGraw-Hill', '실수 체계의 엄밀한 수학적 기초를 학습한다.', '1주:실수, 2주:수열, 3주:급수, 4주:연속함수, 5주:균등연속, 6주:미분, 7주:중간고사, 8주:평균값정리, 9주:리만적분, 10주:적분가능, 11주:함수열, 12주:균등수렴, 13주:실습, 14주:복습, 15주:기말고사', 3, 20, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5022, 20102001, 201, 2026, 1, '수학교양', 2, 'GENERAL_ELECTIVE', '담당교수 배포 자료', '일상생활 속 수학 원리와 사고법을 학습한다.', '1주:OT, 2주:논리, 3주:집합, 4주:확률직관, 5주:통계해석, 6주:기하, 7주:중간평가, 8주:함수, 9주:수열, 10주:이산수학, 11주:게임이론, 12주:암호, 13주:최종발표, 14주:복습, 15주:기말평가', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL);

-- 물리학과 (202) - 오수진
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5023, 20122001, 202, 2026, 1, '일반물리학', 3, 'MAJOR_REQUIRED', 'Halliday, Fundamentals of Physics, Wiley', '역학, 열역학, 전자기학, 현대물리 기초를 이해한다.', '1주:측정, 2주:운동학, 3주:뉴턴법칙, 4주:일과에너지, 5주:운동량, 6주:회전, 7주:중간고사, 8주:중력, 9주:유체, 10주:열역학기초, 11주:파동, 12주:광학, 13주:전기기초, 14주:복습, 15주:기말고사', 1, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5024, 20122001, 202, 2026, 1, '열역학', 3, 'MAJOR_REQUIRED', 'Callen, Thermodynamics, Wiley', '열역학 4법칙과 통계역학 기초를 이해한다.', '1주:OT, 2주:0·1법칙, 3주:이상기체, 4주:2법칙, 5주:엔트로피, 6주:헬름홀츠, 7주:중간고사, 8주:깁스, 9주:상변화, 10주:통계역학, 11주:볼츠만, 12주:양자통계, 13주:실습, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5025, 20122001, 202, 2026, 1, '전자기학', 3, 'MAJOR_REQUIRED', 'Griffiths, Electrodynamics, Pearson', '전자기장과 전자기파의 특성을 수학적으로 이해한다.', '1주:벡터해석, 2주:정전기학, 3주:가우스, 4주:전기퍼텐셜, 5주:도체, 6주:정자기학, 7주:중간고사, 8주:앙페르, 9주:패러데이, 10주:맥스웰, 11주:전자기파, 12주:도파관, 13주:복사, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5026, 20122001, 202, 2026, 1, '물리실험', 2, 'MAJOR_ELECTIVE', '담당교수 배포 실험지침서', '기초 물리 실험을 통해 측정 원리와 데이터 분석을 학습한다.', '1주:OT, 2주:역학I, 3주:역학II, 4주:역학III, 5주:열실험I, 6주:열실험II, 7주:중간평가, 8주:전기I, 9주:전기II, 10주:광학I, 11주:광학II, 12주:현대물리, 13주:자유실험, 14주:보고서, 15주:기말평가', 2, 20, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5027, 20122001, 202, 2025, 2, '양자역학', 3, 'MAJOR_ELECTIVE', 'Griffiths, Quantum Mechanics, Pearson', '양자역학의 기본 공리와 슈뢰딩거 방정식을 학습한다.', '1주:이중성, 2주:슈뢰딩거방정식, 3주:무한우물, 4주:조화진동자, 5주:수소원자, 6주:각운동량, 7주:중간고사, 8주:스핀, 9주:에너지준위, 10주:섭동, 11주:변분법, 12주:산란, 13주:상대론, 14주:복습, 15주:기말고사', 3, 20, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL);

-- 심리학과 (301) - 최영희
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5028, 20202001, 301, 2026, 1, '심리학개론', 3, 'MAJOR_REQUIRED', 'Myers, Psychology, Worth Publishers', '심리학의 주요 분야와 기본 개념을 이해한다.', '1주:심리학이란, 2주:연구방법, 3주:신경과학, 4주:의식, 5주:감각, 6주:학습, 7주:중간고사, 8주:기억, 9주:인지, 10주:동기와정서, 11주:성격, 12주:사회심리, 13주:이상심리, 14주:복습, 15주:기말고사', 1, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5029, 20202001, 301, 2026, 1, '발달심리학', 3, 'MAJOR_REQUIRED', 'Santrock, Child Development, McGraw-Hill', '인간의 전 생애에 걸친 발달 과정을 이해한다.', '1주:OT, 2주:연구방법, 3주:태아기, 4주:영아기, 5주:유아기인지, 6주:유아기사회, 7주:중간고사, 8주:아동기, 9주:청소년기, 10주:성인초기, 11주:중년기, 12주:노년기, 13주:죽음, 14주:복습, 15주:기말고사', 2, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5030, 20202001, 301, 2026, 1, '인지심리학', 3, 'MAJOR_REQUIRED', 'Sternberg, Cognitive Psychology, Cengage', '주의, 기억, 사고 등 인지 과정을 학습한다.', '1주:OT, 2주:주의, 3주:지각, 4주:단기기억, 5주:장기기억, 6주:망각, 7주:중간고사, 8주:언어, 9주:사고, 10주:문제해결, 11주:의사결정, 12주:인공지능과인지, 13주:실습, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5031, 20202001, 301, 2026, 1, '심리학교양', 2, 'GENERAL_ELECTIVE', '담당교수 배포 자료', '일상생활에서 활용할 수 있는 심리학 지식을 학습한다.', '1주:OT, 2주:자기이해, 3주:관계심리, 4주:스트레스, 5주:동기, 6주:행복심리, 7주:중간평가, 8주:학습심리, 9주:집단행동, 10주:편견, 11주:리더십, 12주:상담기초, 13주:최종발표, 14주:복습, 15주:기말평가', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5032, 20202001, 301, 2025, 2, '사회심리학', 3, 'MAJOR_ELECTIVE', 'Aronson, Social Psychology, Pearson', '사회적 환경이 행동에 미치는 영향을 분석한다.', '1주:OT, 2주:사회인지, 3주:자기개념, 4주:태도, 5주:설득, 6주:사회적영향, 7주:중간고사, 8주:동조, 9주:복종, 10주:집단행동, 11주:편견, 12주:공격성, 13주:이타주의, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5033, 20202001, 301, 2024, 2, '상담심리학', 3, 'MAJOR_ELECTIVE', '이장호, 상담심리학, 박영사', '상담의 기본 원리와 주요 상담이론을 학습한다.', '1주:OT, 2주:상담관계, 3주:상담기술, 4주:경청과공감, 5주:정신분석, 6주:인지치료, 7주:중간고사, 8주:행동치료, 9주:인본주의, 10주:게슈탈트, 11주:집단상담, 12주:위기상담, 13주:역할연습, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2024-09-02 00:00:00', '2024-12-20 00:00:00', FALSE, '2024-07-01 09:00:00', NULL, NULL);

-- 경영학과 (601) - 박철수, 신미래
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5034, 20152001, 601, 2026, 1, '경영학원론', 3, 'MAJOR_REQUIRED', '이학종, 경영학원론, 법문사', '경영학 기본 개념과 기업 경영 활동을 이해한다.', '1주:개요, 2주:경영환경, 3주:경영계획, 4주:조직설계, 5주:리더십, 6주:동기부여, 7주:중간고사, 8주:마케팅, 9주:재무, 10주:인사, 11주:생산, 12주:정보, 13주:글로벌, 14주:복습, 15주:기말고사', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5035, 20152001, 601, 2026, 1, '회계원리', 3, 'MAJOR_REQUIRED', '신현걸, 최신 회계원리, 탐진', '재무회계의 기본 원리를 이해하고 재무제표를 작성한다.', '1주:OT, 2주:회계등식, 3주:분개, 4주:전기, 5주:수정분개, 6주:재무제표, 7주:중간고사, 8주:상품거래, 9주:현금, 10주:매출채권, 11주:재고자산, 12주:비유동자산, 13주:부채와자본, 14주:복습, 15주:기말고사', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5036, 20132001, 601, 2026, 1, '재무관리', 3, 'MAJOR_REQUIRED', '이상빈, 재무관리, 경문사', '기업의 재무 의사결정 원리를 이해한다.', '1주:OT, 2주:화폐시간가치, 3주:채권, 4주:주식, 5주:위험과수익률, 6주:포트폴리오, 7주:중간고사, 8주:CAPM, 9주:자본구조, 10주:배당, 11주:투자결정, 12주:기업가치, 13주:파생상품, 14주:복습, 15주:기말고사', 2, 35, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5037, 20132001, 601, 2026, 1, '인사조직론', 3, 'MAJOR_ELECTIVE', 'Robbins, Organizational Behavior, Pearson', '조직 내 인간행동과 효과적 인사관리를 학습한다.', '1주:OT, 2주:개인차이, 3주:동기부여, 4주:집단역학, 5주:팀관리, 6주:리더십, 7주:중간고사, 8주:의사소통, 9주:갈등관리, 10주:조직문화, 11주:조직변화, 12주:인사평가, 13주:채용훈련, 14주:복습, 15주:기말고사', 3, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5038, 20132001, 601, 2026, 1, '스타트업경영', 2, 'MAJOR_ELECTIVE', '임정욱, 스타트업 바이블, 다산북스', '스타트업 창업과 성장 전략을 이해한다.', '1주:OT, 2주:린스타트업, 3주:MVP, 4주:고객발견, 5주:BMC, 6주:피칭, 7주:중간발표, 8주:투자유치, 9주:법인설립, 10주:팀빌딩, 11주:그로스해킹, 12주:케이스, 13주:최종발표, 14주:복습, 15주:기말고사', 4, 25, 'REJECTED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-02-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5039, 20152001, 601, 2025, 2, '마케팅원론', 3, 'MAJOR_REQUIRED', 'Kotler, Marketing Management, Pearson', 'STP 전략과 4P 믹스를 이해하고 적용한다.', '1주:OT, 2주:마케팅환경, 3주:소비자행동, 4주:시장조사, 5주:STP, 6주:제품, 7주:중간고사, 8주:가격, 9주:유통, 10주:촉진, 11주:디지털마케팅, 12주:서비스, 13주:케이스, 14주:복습, 15주:기말고사', 2, 35, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL);

-- 전자공학과 (402) - 장현석
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5040, 20082001, 402, 2026, 1, '전기회로이론', 3, 'MAJOR_REQUIRED', 'Sadiku, Electric Circuits, McGraw-Hill', '회로망 해석과 AC/DC 회로 원리를 이해한다.', '1주:OT, 2주:옴의법칙, 3주:KVL·KCL, 4주:노드, 5주:메시, 6주:테브냉, 7주:중간고사, 8주:교류, 9주:임피던스, 10주:공진, 11주:주파수응답, 12주:라플라스, 13주:실습, 14주:복습, 15주:기말고사', 1, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5041, 20082001, 402, 2026, 1, '디지털회로설계', 3, 'MAJOR_REQUIRED', '김종현, 디지털논리설계, 생능출판사', '논리게이트부터 FPGA까지 디지털 시스템 설계를 익힌다.', '1주:OT, 2주:수체계, 3주:논리게이트, 4주:부울대수, 5주:카르노맵, 6주:조합논리, 7주:중간고사, 8주:MUX·DEMUX, 9주:순서논리, 10주:플립플롭, 11주:카운터, 12주:레지스터, 13주:FPGA, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5042, 20082001, 402, 2026, 1, '전자공학실습', 2, 'MAJOR_REQUIRED', '담당교수 배포 자료', '전자회로의 동작 원리를 실험을 통해 검증한다.', '1주:OT, 2주:측정장비, 3주:DC회로, 4주:AC회로, 5주:다이오드, 6주:트랜지스터, 7주:중간평가, 8주:OP-AMP, 9주:디지털게이트, 10주:플립플롭, 11주:카운터, 12주:센서회로, 13주:프로젝트, 14주:발표, 15주:기말평가', 2, 20, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5043, 20082001, 402, 2026, 1, '임베디드시스템', 3, 'MAJOR_ELECTIVE', '임성수, 임베디드 시스템 프로그래밍, 아진', '마이크로컨트롤러 기반 임베디드 시스템을 실습한다.', '1주:OT, 2주:ARM구조, 3주:GPIO, 4주:인터럽트, 5주:타이머, 6주:UART, 7주:중간고사, 8주:SPI·I2C, 9주:ADC·DAC, 10주:RTOS, 11주:센서, 12주:디바이스드라이버, 13주:프로젝트, 14주:복습, 15주:기말고사', 3, 25, 'PENDING', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-02-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5044, 20082001, 402, 2025, 2, '신호및시스템', 3, 'MAJOR_ELECTIVE', 'Oppenheim, Signals and Systems, Pearson', '신호 분석 기법과 시스템 특성을 이해한다.', '1주:OT, 2주:시스템특성, 3주:LTI, 4주:합성곱, 5주:푸리에급수, 6주:푸리에변환, 7주:중간고사, 8주:라플라스, 9주:z변환, 10주:샘플링, 11주:필터, 12주:DFT, 13주:실습, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL);

-- 국어국문학과 (101) - 류성호
INSERT INTO lecture (lecture_id, member_code, major_id, year, semester, lecture_name, credit, lecture_type, ref_books, goal, weekly_plan, academic_year, max_std, status, start_date, end_date, is_del, created_at, updated_at, deleted_at) VALUES
                                                                                                                                                                                                                        (5045, 20182001, 101, 2026, 1, '국문학개론', 3, 'MAJOR_REQUIRED', '김흥규, 한국문학의 이해, 민음사', '한국문학의 역사적 흐름과 주요 장르를 학습한다.', '1주:문학이란, 2주:고대문학, 3주:삼국시대, 4주:고려, 5주:조선전기, 6주:조선후기, 7주:중간고사, 8주:개화기, 9주:1920년대, 10주:1930년대, 11주:해방후, 12주:현대문학, 13주:분석, 14주:복습, 15주:기말고사', 1, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5046, 20182001, 101, 2026, 1, '한국어문법론', 3, 'MAJOR_REQUIRED', '남기심·고영근, 표준국어문법론, 탑출판사', '한국어의 음운·형태·통사 구조를 분석한다.', '1주:OT, 2주:음운론, 3주:음운현상, 4주:형태론, 5주:품사, 6주:조사와어미, 7주:중간고사, 8주:통사론, 9주:문장구조, 10주:높임법, 11주:시제, 12주:부정문, 13주:실습, 14주:복습, 15주:기말고사', 2, 30, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5047, 20182001, 101, 2026, 1, '글쓰기와소통', 2, 'GENERAL_REQUIRED', '담당교수 배포 자료', '대학 수준의 글쓰기와 의사소통 능력을 기른다.', '1주:OT, 2주:문단구성, 3주:논리적글쓰기, 4주:요약, 5주:비판적쓰기, 6주:이메일, 7주:중간평가, 8주:발표, 9주:토론, 10주:보고서, 11주:서평, 12주:창의적쓰기, 13주:최종발표, 14주:복습, 15주:기말평가', 1, 40, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5048, 20182001, 101, 2026, 1, '고전문학사', 3, 'MAJOR_ELECTIVE', '장덕순, 한국문학사, 동화문화사', '고대부터 조선시대까지 한국 문학사를 학습한다.', '1주:OT, 2주:구비문학, 3주:향가, 4주:고려속요, 5주:시조, 6주:가사, 7주:중간고사, 8주:한문학, 9주:소설발생, 10주:고전소설, 11주:판소리, 12주:민속극, 13주:발표, 14주:복습, 15주:기말고사', 3, 25, 'APPROVED', '2026-03-02 00:00:00', '2026-06-20 00:00:00', FALSE, '2026-01-10 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5049, 20182001, 101, 2025, 2, '현대시론', 3, 'MAJOR_ELECTIVE', '오세영, 현대시론, 새미', '현대시의 형식과 내용을 분석한다.', '1주:OT, 2주:시의형식, 3주:심상비유, 4주:운율, 5주:상징주의, 6주:모더니즘, 7주:중간고사, 8주:리얼리즘, 9주:1960년대, 10주:1970년대, 11주:1980년대, 12주:분석, 13주:발표, 14주:복습, 15주:기말고사', 2, 25, 'APPROVED', '2025-09-01 00:00:00', '2025-12-19 00:00:00', FALSE, '2025-07-01 09:00:00', NULL, NULL),
                                                                                                                                                                                                                        (5050, 20182001, 101, 2024, 2, '창작실습', 2, 'MAJOR_ELECTIVE', '담당교수 배포 자료', '시와 산문 창작을 통해 표현 능력을 기른다.', '1주:OT, 2주:시쓰기기초, 3주:시실습I, 4주:시실습II, 5주:단편기초, 6주:소설실습I, 7주:중간발표, 8주:소설실습II, 9주:수필, 10주:수필실습, 11주:상호비평I, 12주:상호비평II, 13주:최종완성, 14주:복습, 15주:최종발표', 3, 20, 'APPROVED', '2024-09-02 00:00:00', '2024-12-20 00:00:00', FALSE, '2024-07-01 09:00:00', NULL, NULL);

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- classroom 더미데이터
-- 규칙: 비고에 명시된 12개 건물 전부 포함
-- 강의실 총 30개 (건물별 2~3개)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO classroom (room_id, building, room, capacity) VALUES
-- 인문관 (3개)
(1, '인문관', '101호', 40),
(2, '인문관', '102호', 40),
(3, '인문관', '201호', 35),

-- 공학관 (4개 - 컴퓨터공학과, 전자공학과 사용)
(4, '공학관', '101호', 40),
(5, '공학관', '102호', 40),
(6, '공학관', '201호', 35),
(7, '공학관', '실습실', 25),

-- 자연과학관 (3개 - 수학과, 물리학과 사용)
(8, '자연과학관', '101호', 35),
(9, '자연과학관', '102호', 35),
(10, '자연과학관', '실험실', 20),

-- 사회과학관 (2개 - 심리학과 사용)
(11, '사회과학관', '101호', 40),
(12, '사회과학관', '102호', 35),

-- 경영관 (3개 - 경영학과 사용)
(13, '경영관', '101호', 50),
(14, '경영관', '102호', 50),
(15, '경영관', '세미나실', 20),

-- 법학관 (2개)
(16, '법학관', '101호', 40),
(17, '법학관', '102호', 30),

-- 예술관 (2개)
(18, '예술관', '실기실A', 25),
(19, '예술관', '실기실B', 25),

-- 체육관 (2개)
(20, '체육관', '대강당', 100),
(21, '체육관', '소강당',  50),

-- 도서관 (2개)
(22, '도서관', '세미나실A', 10),
(23, '도서관', '세미나실B', 10),

-- 학생회관 (2개)
(24, '학생회관', '회의실A', 15),
(25, '학생회관', '회의실B', 20),

-- 대학본부 (2개)
(26, '대학본부', '대회의실', 50),
(27, '대학본부', '소회의실', 15),

-- 실험동 (3개)
(28, '실험동', '실험실101', 20),
(29, '실험동', '실험실102', 20),
(30, '실험동', '실험실201', 15);


-- [PART 6-B] 강의 시간표 (lecture_schedule)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 16. 강의 시간표 (lecture_schedule)
-- 규칙 10번: 월~금 09:00~17:00 사이 다양한 시간대
-- 교시 체계: 1교시(09:00-10:00), 2교시(10:00-11:00) ... 8교시(16:00-17:00)
-- 학점=강의 시간 (1학점=1교시, 2학점=2교시, 3학점=3교시)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- lecture_schedule
-- classroom의 room_id 참조
-- 학과별 건물 매핑:
--   인문관(1,2,3)        → 국어국문(101), 영어영문(102)
--   공학관(4,5,6,7)      → 컴퓨터공학(401), 전자공학(402)
--   자연과학관(8,9,10)   → 수학(201), 물리(202)
--   사회과학관(11,12)    → 심리(301)
--   경영관(13,14,15)     → 경영(601)

INSERT INTO lecture_schedule (schedule_id, lecture_id, room_id, day_of_week, start_period, end_period) VALUES
-- 컴퓨터공학과 (공학관 4,5,6,7)
(6001, 5001, 4, '월', 1, 3),   -- 프로그래밍기초 (3학점=3교시)
(6002, 5002, 4, '화', 1, 3),   -- 자료구조
(6003, 5003, 4, '수', 1, 3),   -- 운영체제
(6004, 5004, 5, '월', 4, 6),   -- 알고리즘
(6005, 5005, 5, '화', 4, 6),   -- 데이터베이스
(6006, 5006, 5, '수', 4, 6),   -- 컴퓨터구조
(6007, 5007, 6, '목', 1, 3),   -- 소프트웨어공학 (PENDING)
(6008, 5008, 6, '금', 1, 3),   -- 캡스톤디자인
(6009, 5009, 7, '목', 5, 7),   -- 인공지능개론 (2025-2)
(6010, 5010, 7, '금', 5, 6),   -- 웹프로그래밍 (2025-2)

-- 영어영문학과 (인문관 1,2,3)
(6011, 5011, 1, '월', 1, 2),   -- 영어회화 (2학점)
(6012, 5012, 1, '화', 1, 3),   -- 영문법 (3학점)
(6013, 5013, 2, '수', 1, 3),   -- 영어독해
(6014, 5014, 2, '목', 3, 5),   -- 셰익스피어문학
(6015, 5015, 1, '금', 1, 2),   -- 영어교양
(6016, 5016, 3, '월', 4, 6),   -- 영문학개론 (2025-2)

-- 수학과 (자연과학관 8,9)
(6017, 5017, 8, '월', 1, 3),   -- 미적분학
(6018, 5018, 8, '화', 1, 3),   -- 선형대수
(6019, 5019, 8, '수', 1, 3),   -- 확률과통계
(6020, 5020, 9, '목', 1, 3),   -- 수리통계학 (PENDING)
(6021, 5021, 8, '금', 4, 6),   -- 해석학 (2025-2)
(6022, 5022, 9, '금', 1, 2),   -- 수학교양

-- 물리학과 (자연과학관 9,10)
(6023, 5023, 9, '월', 4, 6),   -- 일반물리학
(6024, 5024, 9, '화', 4, 6),   -- 열역학
(6025, 5025, 9, '수', 4, 6),   -- 전자기학
(6026, 5026, 10,'목', 4, 5),   -- 물리실험 (2학점)
(6027, 5027, 10,'금', 5, 7),   -- 양자역학 (2025-2)

-- 심리학과 (사회과학관 11,12)
(6028, 5028, 11,'월', 1, 3),   -- 심리학개론
(6029, 5029, 11,'화', 1, 3),   -- 발달심리학
(6030, 5030, 11,'수', 1, 3),   -- 인지심리학
(6031, 5031, 12,'목', 1, 2),   -- 심리학교양
(6032, 5032, 12,'금', 1, 3),   -- 사회심리학 (2025-2)
(6033, 5033, 11,'월', 4, 6),   -- 상담심리학 (2024-2)

-- 경영학과 (경영관 13,14,15)
(6034, 5034, 13,'월', 1, 3),   -- 경영학원론
(6035, 5035, 13,'화', 1, 3),   -- 회계원리
(6036, 5036, 14,'수', 1, 3),   -- 재무관리
(6037, 5037, 14,'목', 1, 3),   -- 인사조직론
(6038, 5038, 15,'금', 1, 2),   -- 스타트업경영 (REJECTED)
(6039, 5039, 14,'금', 4, 6),   -- 마케팅원론 (2025-2)

-- 전자공학과 (공학관 6,7)
(6040, 5040, 6, '월', 5, 7),   -- 전기회로이론
(6041, 5041, 6, '화', 5, 7),   -- 디지털회로설계
(6042, 5042, 7, '수', 5, 6),   -- 전자공학실습
(6043, 5043, 7, '목', 5, 7),   -- 임베디드시스템 (PENDING)
(6044, 5044, 7, '금', 5, 7),   -- 신호및시스템 (2025-2)

-- 국어국문학과 (인문관 1,2,3)
(6045, 5045, 1, '월', 5, 7),   -- 국문학개론
(6046, 5046, 1, '화', 5, 7),   -- 한국어문법론
(6047, 5047, 2, '수', 5, 6),   -- 글쓰기와소통
(6048, 5048, 2, '목', 6, 8),   -- 고전문학사
(6049, 5049, 3, '금', 5, 7),   -- 현대시론 (2025-2)
(6050, 5050, 3, '월', 7, 8);   -- 창작실습 (2024-2)


-- [PART 6-C] 수강신청 (course)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 17. 수강신청 (course) - 규칙 11번: PENDING/APPROVED/REJECTED
-- APPROVED 상태인 강의(2026-1학기 위주)에 학생들 배정
-- 학과별 전공 강의 + 교양 강의 1~2개씩 다양하게 분배
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- 컴퓨터공학과 학생들의 컴공 전공 수강 (5001~5008 중심)
INSERT INTO course (course_id, student_code, lecture_id, year, semester, created_at) VALUES
-- 컴공 1학년 (프로그래밍기초 5001) - 20261001, 20261009, 20261017
(7001, 20261001, 5001, 2026, 1, '2026-02-05 10:00:00'),
(7002, 20261009, 5001, 2026, 1, '2026-02-05 10:01:00'),
(7003, 20261017, 5001, 2026, 1, '2026-02-05 10:02:00'),
-- 컴공 2학년 (자료구조 5002, 알고리즘 5004)
(7004, 20251001, 5002, 2026, 1, '2026-02-05 10:03:00'),
(7005, 20251009, 5002, 2026, 1, '2026-02-05 10:04:00'),
(7006, 20251017, 5002, 2026, 1, '2026-02-05 10:05:00'),
(7007, 20251025, 5002, 2026, 1, '2026-02-05 10:06:00'),
(7008, 20251001, 5004, 2026, 1, '2026-02-05 10:07:00'),
(7009, 20251009, 5004, 2026, 1, '2026-02-05 10:08:00'),
(7010, 20251017, 5004, 2026, 1, '2026-02-05 10:09:00'),
-- 컴공 3학년 (운영체제 5003, 데이터베이스 5005, 컴퓨터구조 5006)
(7011, 20241001, 5003, 2026, 1, '2026-02-05 11:00:00'),
(7012, 20241009, 5003, 2026, 1, '2026-02-05 11:01:00'),
(7013, 20241017, 5003, 2026, 1, '2026-02-05 11:02:00'),
(7014, 20241025, 5003, 2026, 1, '2026-02-05 11:03:00'),
(7015, 20241001, 5005, 2026, 1, '2026-02-05 11:04:00'),
(7016, 20241009, 5005, 2026, 1, '2026-02-05 11:05:00'),
(7017, 20241017, 5005, 2026, 1, '2026-02-05 11:06:00'),
(7018, 20241025, 5005, 2026, 1, '2026-02-05 11:07:00'),
(7019, 20241001, 5006, 2026, 1, '2026-02-05 11:08:00'),
(7020, 20241009, 5006, 2026, 1, '2026-02-05 11:09:00'),
-- 컴공 4학년 (캡스톤 5008) - 4학년 컴공 학생들
(7021, 20231001, 5008, 2026, 1, '2026-02-05 12:00:00'),
(7022, 20231009, 5008, 2026, 1, '2026-02-05 12:01:00'),
(7023, 20231017, 5008, 2026, 1, '2026-02-05 12:02:00'),
-- 영문과 학생들 (영어회화 5011, 영문법 5012, 영어독해 5013)
(7024, 20261002, 5011, 2026, 1, '2026-02-06 09:00:00'),
(7025, 20261010, 5011, 2026, 1, '2026-02-06 09:01:00'),
(7026, 20261018, 5011, 2026, 1, '2026-02-06 09:02:00'),
(7027, 20251002, 5012, 2026, 1, '2026-02-06 09:03:00'),
(7028, 20251010, 5012, 2026, 1, '2026-02-06 09:04:00'),
(7029, 20251018, 5012, 2026, 1, '2026-02-06 09:05:00'),
(7030, 20241002, 5013, 2026, 1, '2026-02-06 09:06:00'),
(7031, 20241018, 5013, 2026, 1, '2026-02-06 09:07:00'),
(7032, 20231002, 5014, 2026, 1, '2026-02-06 09:08:00'),
(7033, 20231010, 5014, 2026, 1, '2026-02-06 09:09:00'),
-- 수학과 학생들 (미적분 5017, 선형대수 5018, 확률통계 5019)
(7034, 20261005, 5017, 2026, 1, '2026-02-06 10:00:00'),
(7035, 20261013, 5017, 2026, 1, '2026-02-06 10:01:00'),
(7036, 20251005, 5018, 2026, 1, '2026-02-06 10:02:00'),
(7037, 20251013, 5018, 2026, 1, '2026-02-06 10:03:00'),
(7038, 20251021, 5018, 2026, 1, '2026-02-06 10:04:00'),
(7039, 20241005, 5019, 2026, 1, '2026-02-06 10:05:00'),
(7040, 20241013, 5019, 2026, 1, '2026-02-06 10:06:00'),
(7041, 20241021, 5019, 2026, 1, '2026-02-06 10:07:00'),
(7042, 20231005, 5020, 2026, 1, '2026-02-06 10:08:00'),
(7043, 20231013, 5020, 2026, 1, '2026-02-06 10:09:00'),
-- 물리과 학생들 (일반물리 5023, 열역학 5024, 전자기학 5025)
(7044, 20261008, 5023, 2026, 1, '2026-02-06 11:00:00'),
(7045, 20261016, 5023, 2026, 1, '2026-02-06 11:01:00'),
(7046, 20251008, 5024, 2026, 1, '2026-02-06 11:02:00'),
(7047, 20251016, 5024, 2026, 1, '2026-02-06 11:03:00'),
(7048, 20251024, 5024, 2026, 1, '2026-02-06 11:04:00'),
(7049, 20241008, 5025, 2026, 1, '2026-02-06 11:05:00'),
(7050, 20241016, 5025, 2026, 1, '2026-02-06 11:06:00'),
(7051, 20231016, 5026, 2026, 1, '2026-02-06 11:07:00'),
-- 심리과 학생들 (심리학개론 5028, 발달심리 5029, 인지심리 5030)
(7052, 20261004, 5028, 2026, 1, '2026-02-06 12:00:00'),
(7053, 20261012, 5028, 2026, 1, '2026-02-06 12:01:00'),
(7054, 20261020, 5028, 2026, 1, '2026-02-06 12:02:00'),
(7055, 20251012, 5029, 2026, 1, '2026-02-06 12:03:00'),
(7056, 20251020, 5029, 2026, 1, '2026-02-06 12:04:00'),
(7057, 20241004, 5030, 2026, 1, '2026-02-06 12:05:00'),
(7058, 20241012, 5030, 2026, 1, '2026-02-06 12:06:00'),
(7059, 20241020, 5030, 2026, 1, '2026-02-06 12:07:00'),
-- 경영과 학생들 (경영원론 5034, 회계원리 5035, 재무관리 5036)
(7060, 20261003, 5034, 2026, 1, '2026-02-06 13:00:00'),
(7061, 20261011, 5034, 2026, 1, '2026-02-06 13:01:00'),
(7062, 20261019, 5034, 2026, 1, '2026-02-06 13:02:00'),
(7063, 20251003, 5035, 2026, 1, '2026-02-06 13:03:00'),
(7064, 20251011, 5035, 2026, 1, '2026-02-06 13:04:00'),
(7065, 20251019, 5035, 2026, 1, '2026-02-06 13:05:00'),
(7066, 20241011, 5036, 2026, 1, '2026-02-06 13:06:00'),
(7067, 20241019, 5036, 2026, 1, '2026-02-06 13:07:00'),
(7068, 20231003, 5036, 2026, 1, '2026-02-06 13:08:00'),
(7069, 20231011, 5037, 2026, 1, '2026-02-06 13:09:00'),
(7070, 20231019, 5037, 2026, 1, '2026-02-06 13:10:00'),
-- 전자공학과 학생들 (전기회로 5040, 디지털회로 5041, 전자공학실습 5042)
(7071, 20261006, 5040, 2026, 1, '2026-02-06 14:00:00'),
(7072, 20261014, 5040, 2026, 1, '2026-02-06 14:01:00'),
(7073, 20251006, 5041, 2026, 1, '2026-02-06 14:02:00'),
(7074, 20251014, 5041, 2026, 1, '2026-02-06 14:03:00'),
(7075, 20251022, 5041, 2026, 1, '2026-02-06 14:04:00'),
(7076, 20241006, 5042, 2026, 1, '2026-02-06 14:05:00'),
(7077, 20241014, 5042, 2026, 1, '2026-02-06 14:06:00'),
(7078, 20241022, 5042, 2026, 1, '2026-02-06 14:07:00'),
-- 국문과 학생들 (국문학개론 5045, 한국어문법론 5046)
(7079, 20261007, 5045, 2026, 1, '2026-02-06 15:00:00'),
(7080, 20261015, 5045, 2026, 1, '2026-02-06 15:01:00'),
(7081, 20251007, 5046, 2026, 1, '2026-02-06 15:02:00'),
(7082, 20251015, 5046, 2026, 1, '2026-02-06 15:03:00'),
(7083, 20251023, 5046, 2026, 1, '2026-02-06 15:04:00'),
(7084, 20241007, 5048, 2026, 1, '2026-02-06 15:05:00'),
(7085, 20241015, 5048, 2026, 1, '2026-02-06 15:06:00'),
(7086, 20241023, 5048, 2026, 1, '2026-02-06 15:07:00'),
-- 교양 강의 (영어교양 5015, 수학교양 5022, 심리학교양 5031, 글쓰기와소통 5047)
(7087, 20261001, 5015, 2026, 1, '2026-02-07 09:00:00'),
(7088, 20261002, 5015, 2026, 1, '2026-02-07 09:01:00'),
(7089, 20261003, 5022, 2026, 1, '2026-02-07 09:02:00'),
(7090, 20261004, 5031, 2026, 1, '2026-02-07 09:03:00'),
(7091, 20261005, 5047, 2026, 1, '2026-02-07 09:04:00'),
(7092, 20261006, 5047, 2026, 1, '2026-02-07 09:05:00'),
(7093, 20261007, 5015, 2026, 1, '2026-02-07 09:06:00'),
(7094, 20261008, 5022, 2026, 1, '2026-02-07 09:07:00'),
-- 2025-2학기 (이미 종료) 데이터 - 성적 입력 및 강의평가 테스트용
(7095, 20241001, 5009, 2025, 2, '2025-08-15 10:00:00'),  -- AI개론
(7096, 20241009, 5009, 2025, 2, '2025-08-15 10:01:00'),
(7097, 20241001, 5010, 2025, 2, '2025-08-15 10:02:00'),  -- 웹프로그래밍
(7098, 20241009, 5010, 2025, 2, '2025-08-15 10:03:00'),
(7099, 20231001, 5009, 2025, 2, '2025-08-15 10:04:00'),
(7100, 20231009, 5010, 2025, 2, '2025-08-15 10:05:00');


-- [PART 6-D] 출석 + 성적 + 등록금 + 장학금 + 공지사항
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 18. 출석세션 (attendance_session) - 5001 강의 일부 회차
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- attendance_session 더미데이터
-- 강의 5001(프로그래밍기초) - 9회차 (월요일 수업)
-- 강의 5002(자료구조)       - 3회차
-- 강의 5028(심리학개론)     - 3회차 (1회 휴강·보강 포함)
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO attendance_session
(attendsession_id, lecture_id, is_active, session_type, class_date, original_date, started_at, ended_at)
VALUES
-- ─────────────────────────────────────────
-- 5001 프로그래밍기초 (월요일 9회차 - NORMAL)
-- ─────────────────────────────────────────
(8001, 5001, FALSE, 'NORMAL', '2026-03-02', NULL, '2026-03-02 09:00:00', '2026-03-02 09:10:00'),
(8002, 5001, FALSE, 'NORMAL', '2026-03-09', NULL, '2026-03-09 09:00:00', '2026-03-09 09:10:00'),
(8003, 5001, FALSE, 'NORMAL', '2026-03-16', NULL, '2026-03-16 09:00:00', '2026-03-16 09:10:00'),
(8004, 5001, FALSE, 'NORMAL', '2026-03-23', NULL, '2026-03-23 09:00:00', '2026-03-23 09:10:00'),
(8005, 5001, FALSE, 'NORMAL', '2026-03-30', NULL, '2026-03-30 09:00:00', '2026-03-30 09:10:00'),
(8006, 5001, FALSE, 'NORMAL', '2026-04-06', NULL, '2026-04-06 09:00:00', '2026-04-06 09:10:00'),
(8007, 5001, FALSE, 'NORMAL', '2026-04-13', NULL, '2026-04-13 09:00:00', '2026-04-13 09:10:00'),
(8008, 5001, FALSE, 'NORMAL', '2026-04-20', NULL, '2026-04-20 09:00:00', '2026-04-20 09:10:00'),
(8009, 5001, FALSE, 'NORMAL', '2026-04-27', NULL, '2026-04-27 09:00:00', '2026-04-27 09:10:00'),

-- ─────────────────────────────────────────
-- 5002 자료구조 (화요일 3회차 - NORMAL)
-- ─────────────────────────────────────────
(8010, 5002, FALSE, 'NORMAL', '2026-03-03', NULL, '2026-03-03 09:00:00', '2026-03-03 09:10:00'),
(8011, 5002, FALSE, 'NORMAL', '2026-03-10', NULL, '2026-03-10 09:00:00', '2026-03-10 09:10:00'),
(8012, 5002, FALSE, 'NORMAL', '2026-03-17', NULL, '2026-03-17 09:00:00', '2026-03-17 09:10:00'),

-- ─────────────────────────────────────────
-- 5028 심리학개론 (월요일 3회차)
-- 1회 정상 → 1회 휴강 → 1회 보강 흐름
-- 휴강/보강 테스트용 데이터
-- ─────────────────────────────────────────

-- 1주차 정상 수업
(8013, 5028, FALSE, 'NORMAL', '2026-03-02', NULL, '2026-03-02 09:00:00', '2026-03-02 09:10:00'),

-- 2주차 휴강 처리
-- (original_date 없음 - 휴강은 원래 수업날짜가 곧 class_date)
(8014, 5028, FALSE, 'CANCEL', '2026-03-09', NULL, '2026-03-09 09:00:00', '2026-03-09 09:05:00'),

-- 3주차 보강 (3월 9일 휴강분을 3월 12일 목요일에 보강)
-- original_date = 원래 휴강했던 날짜
(8015, 5028, FALSE, 'MAKEUP', '2026-03-12', '2026-03-09', '2026-03-12 14:00:00', '2026-03-12 14:10:00');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 19. 출석 기록 (attendance) - 5001강의, 9회차 × 3명
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO attendance (attend_id, attendsession_id, course_id, student_code, status, reason, created_at) VALUES
-- 학생 20261001 (김민준) - 모두 출석
(9001, 8001, 7001, 20261001, 'ATTEND', NULL, '2026-03-02 09:05:00'),
(9002, 8002, 7001, 20261001, 'ATTEND', NULL, '2026-03-09 09:05:00'),
(9003, 8003, 7001, 20261001, 'LATE',   '교통체증', '2026-03-16 09:18:00'),
(9004, 8004, 7001, 20261001, 'ATTEND', NULL, '2026-03-23 09:05:00'),
(9005, 8005, 7001, 20261001, 'ATTEND', NULL, '2026-03-30 09:05:00'),
(9006, 8006, 7001, 20261001, 'ATTEND', NULL, '2026-04-06 09:05:00'),
(9007, 8007, 7001, 20261001, 'ATTEND', NULL, '2026-04-13 09:05:00'),
(9008, 8008, 7001, 20261001, 'ATTEND', NULL, '2026-04-20 09:05:00'),
(9009, 8009, 7001, 20261001, 'ATTEND', NULL, '2026-04-27 09:05:00'),
-- 학생 20261009 (오태양) - 1회 결석
(9010, 8001, 7002, 20261009, 'ATTEND', NULL, '2026-03-02 09:05:00'),
(9011, 8002, 7002, 20261009, 'ATTEND', NULL, '2026-03-09 09:05:00'),
(9012, 8003, 7002, 20261009, 'ATTEND', NULL, '2026-03-16 09:05:00'),
(9013, 8004, 7002, 20261009, 'ABSENT', '병결',  '2026-03-23 09:00:00'),
(9014, 8005, 7002, 20261009, 'ATTEND', NULL, '2026-03-30 09:05:00'),
(9015, 8006, 7002, 20261009, 'ATTEND', NULL, '2026-04-06 09:05:00'),
(9016, 8007, 7002, 20261009, 'LATE',   NULL, '2026-04-13 09:18:00'),
(9017, 8008, 7002, 20261009, 'ATTEND', NULL, '2026-04-20 09:05:00'),
(9018, 8009, 7002, 20261009, 'ATTEND', NULL, '2026-04-27 09:05:00'),
-- 학생 20261017 (안재훈) - 2회 결석
(9019, 8001, 7003, 20261017, 'ATTEND', NULL, '2026-03-02 09:05:00'),
(9020, 8002, 7003, 20261017, 'ABSENT', NULL, '2026-03-09 09:00:00'),
(9021, 8003, 7003, 20261017, 'ATTEND', NULL, '2026-03-16 09:05:00'),
(9022, 8004, 7003, 20261017, 'ATTEND', NULL, '2026-03-23 09:05:00'),
(9023, 8005, 7003, 20261017, 'EARLY_LEAVE', '몸이 안 좋음', '2026-03-30 10:30:00'),
(9024, 8006, 7003, 20261017, 'ATTEND', NULL, '2026-04-06 09:05:00'),
(9025, 8007, 7003, 20261017, 'ATTEND', NULL, '2026-04-13 09:05:00'),
(9026, 8008, 7003, 20261017, 'ABSENT', NULL, '2026-04-20 09:00:00'),
(9027, 8009, 7003, 20261017, 'ATTEND', NULL, '2026-04-27 09:05:00');

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 20. 성적 (grade) - 규칙 13번
-- 2026-1학기 진행 중 → 모든 점수 0, 등급 NULL
-- 2025-2학기 종료 → 점수와 등급 입력 (등급 기준 정확히 적용)
-- 등급: 96~100 A+, 90~95 A, 85~89 B+, 80~84 B, 75~79 C+, 70~74 C, 65~69 D+, 60~64 D, 60미만 F
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

-- 2026-1학기 (전 강의 진행 중 - 모두 0점, 등급 NULL)
INSERT INTO grade (course_id, mid_score, fin_score, assignment_score, attend_score, total_score, grade_letter, created_at) VALUES
                                                                                                                               (7001, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:00:00'),(7002, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:01:00'),(7003, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:02:00'),
                                                                                                                               (7004, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:03:00'),(7005, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:04:00'),(7006, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:05:00'),
                                                                                                                               (7007, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:06:00'),(7008, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:07:00'),(7009, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:08:00'),
                                                                                                                               (7010, 0, 0, 0, 0, 0, NULL, '2026-02-05 10:09:00'),(7011, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:00:00'),(7012, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:01:00'),
                                                                                                                               (7013, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:02:00'),(7014, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:03:00'),(7015, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:04:00'),
                                                                                                                               (7016, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:05:00'),(7017, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:06:00'),(7018, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:07:00'),
                                                                                                                               (7019, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:08:00'),(7020, 0, 0, 0, 0, 0, NULL, '2026-02-05 11:09:00'),(7021, 0, 0, 0, 0, 0, NULL, '2026-02-05 12:00:00'),
                                                                                                                               (7022, 0, 0, 0, 0, 0, NULL, '2026-02-05 12:01:00'),(7024, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:00:00'),(7025, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:01:00'),
                                                                                                                               (7026, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:02:00'),(7027, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:03:00'),(7028, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:04:00'),
                                                                                                                               (7029, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:05:00'),(7030, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:06:00'),(7031, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:07:00'),
                                                                                                                               (7032, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:08:00'),(7033, 0, 0, 0, 0, 0, NULL, '2026-02-06 09:09:00'),(7034, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:00:00'),
                                                                                                                               (7035, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:01:00'),(7036, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:02:00'),(7037, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:03:00'),
                                                                                                                               (7038, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:04:00'),(7039, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:05:00'),(7040, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:06:00'),
                                                                                                                               (7041, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:07:00'),(7043, 0, 0, 0, 0, 0, NULL, '2026-02-06 10:09:00'),(7044, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:00:00'),
                                                                                                                               (7045, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:01:00'),(7046, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:02:00'),(7047, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:03:00'),
                                                                                                                               (7048, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:04:00'),(7049, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:05:00'),(7050, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:06:00'),
                                                                                                                               (7051, 0, 0, 0, 0, 0, NULL, '2026-02-06 11:07:00'),(7052, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:00:00'),(7053, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:01:00'),
                                                                                                                               (7054, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:02:00'),(7055, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:03:00'),(7056, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:04:00'),
                                                                                                                               (7057, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:05:00'),(7058, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:06:00'),(7059, 0, 0, 0, 0, 0, NULL, '2026-02-06 12:07:00'),
                                                                                                                               (7060, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:00:00'),(7061, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:01:00'),(7062, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:02:00'),
                                                                                                                               (7063, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:03:00'),(7064, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:04:00'),(7065, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:05:00'),
                                                                                                                               (7066, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:06:00'),(7067, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:07:00'),(7068, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:08:00'),
                                                                                                                               (7069, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:09:00'),(7070, 0, 0, 0, 0, 0, NULL, '2026-02-06 13:10:00'),(7071, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:00:00'),
                                                                                                                               (7072, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:01:00'),(7073, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:02:00'),(7074, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:03:00'),
                                                                                                                               (7075, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:04:00'),(7076, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:05:00'),(7077, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:06:00'),
                                                                                                                               (7078, 0, 0, 0, 0, 0, NULL, '2026-02-06 14:07:00'),(7079, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:00:00'),(7080, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:01:00'),
                                                                                                                               (7081, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:02:00'),(7083, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:04:00'),(7084, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:05:00'),
                                                                                                                               (7085, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:06:00'),(7086, 0, 0, 0, 0, 0, NULL, '2026-02-06 15:07:00'),(7087, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:00:00'),
                                                                                                                               (7088, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:01:00'),(7089, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:02:00'),(7090, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:03:00'),
                                                                                                                               (7091, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:04:00'),(7092, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:05:00'),(7093, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:06:00'),
                                                                                                                               (7094, 0, 0, 0, 0, 0, NULL, '2026-02-07 09:07:00');

-- 2025-2학기 종료 강의 (성적 입력 완료 - 등급 정확히 매핑)
INSERT INTO grade (course_id, mid_score, fin_score, assignment_score, attend_score, total_score, grade_letter, created_at, updated_at) VALUES
-- AI개론(5009) - 임시우(20241001), 박태양(20241009), 하지원(20231001)
(7095, 28, 29, 19, 20, 96, 'A+', '2025-08-15 10:00:00', '2026-01-02 14:00:00'),  -- 96점=A+
(7096, 26, 27, 18, 19, 90, 'A',  '2025-08-15 10:01:00', '2026-01-02 14:00:00'),  -- 90점=A
-- 웹프로그래밍(5010) - 임시우, 박태양, 도예원
(7097, 25, 26, 17, 18, 86, 'B+', '2025-08-15 10:02:00', '2026-01-02 14:00:00'),  -- 86점=B+
(7098, 22, 23, 16, 19, 80, 'B',  '2025-08-15 10:03:00', '2026-01-02 14:00:00'),  -- 80점=B
(7099, 20, 21, 18, 17, 76, 'C+', '2025-08-15 10:04:00', '2026-01-02 14:00:00'),  -- 76점=C+
(7100, 18, 18, 14, 15, 65, 'D+', '2025-08-15 10:05:00', '2026-01-02 14:00:00');  -- 65점=D+

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 21. 등록금 정책 (tuition_policy) - 규칙 15번
-- 단과대별 300만~500만 원 차등 적용
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO tuition_policy (policy_id, year, semester, college_id, base_amount, created_at, updator_code) VALUES
                                                                                                              (11001, 2026, 1, 1, 3000000, '2025-12-01 09:00:00', 20203001),  -- 인문대학
                                                                                                              (11002, 2026, 1, 2, 3500000, '2025-12-01 09:00:00', 20203001),  -- 자연과학대학
                                                                                                              (11003, 2026, 1, 3, 3000000, '2025-12-01 09:00:00', 20203001),  -- 사회과학대학
                                                                                                              (11004, 2026, 1, 4, 4500000, '2025-12-01 09:00:00', 20203001),  -- 공과대학
                                                                                                              (11005, 2026, 1, 5, 5000000, '2025-12-01 09:00:00', 20203001),  -- 예술대학
                                                                                                              (11006, 2026, 1, 6, 4000000, '2025-12-01 09:00:00', 20203001),  -- 경영대학
                                                                                                              (11007, 2026, 1, 7, 3500000, '2025-12-01 09:00:00', 20203001),  -- 사범대학
                                                                                                              (11008, 2026, 1, 8, 4000000, '2025-12-01 09:00:00', 20203001);  -- 체육대학

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 22. 장학금 종류 (scholarship_type) - 규칙 16, 16-1번
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INSERT INTO scholarship_type (scholarship_type_id, scholarship_type, scholarship_amount) VALUES
                                                                                             (12001, '성적', 1000000),
                                                                                             (12002, '편입학', 500000),
                                                                                             (12003, '보훈', 300000),
                                                                                             (12004, '다자녀', 300000);

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- 23. 공지사항 (announcement) - 시드용 2건만
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
USE my_gu_academic;

INSERT INTO announcement (anno_id, member_code, writer_name, target_role, title, content, view_count, is_del, created_at) VALUES
                                                                                                                              (13001, 20203001, '김행정', 'ALL',     '2026학년도 1학기 개강 안내', '안녕하세요. 2026학년도 1학기 개강을 안내드립니다. 개강일은 3월 2일이며, 자세한 일정은 학사일정을 참고해 주시기 바랍니다.', 0, FALSE, '2026-02-20 09:00:00'),
                                                                                                                              (13002, 20223001, '이관리', 'STUDENT', '학생증 발급 안내',          '신입생 학생증 발급은 3월 첫째 주 학생회관 1층에서 진행됩니다. 신분증 지참 필수.', 0, FALSE, '2026-02-25 10:00:00');


