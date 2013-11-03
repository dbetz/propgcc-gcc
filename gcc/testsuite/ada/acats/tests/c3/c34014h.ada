-- C34014H.ADA

--                             Grant of Unlimited Rights
--
--     Under contracts F33600-87-D-0337, F33600-84-D-0280, MDA903-79-C-0687,
--     F08630-91-C-0015, and DCA100-97-D-0025, the U.S. Government obtained 
--     unlimited rights in the software and documentation contained herein.
--     Unlimited rights are defined in DFAR 252.227-7013(a)(19).  By making 
--     this public release, the Government intends to confer upon all 
--     recipients unlimited rights  equal to those held by the Government.  
--     These rights include rights to use, duplicate, release or disclose the 
--     released technical data and computer software in whole or in part, in 
--     any manner and for any purpose whatsoever, and to have or permit others 
--     to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED 
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE 
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--*
-- OBJECTIVE:
--     CHECK THAT A DERIVED SUBPROGRAM IS VISIBLE AND FURTHER DERIVABLE
--     UNDER APPROPRIATE CIRCUMSTANCES.

--     CHECK WHEN THE DERIVED SUBPROGRAM IS IMPLICITLY DECLARED IN THE
--     PRIVATE PART OF A PACKAGE AFTER AN EXPLICIT DECLARATION OF A
--     HOMOGRAPHIC SUBPROGRAM IN THE VISIBLE PART.

-- HISTORY:
--     JRK 09/16/87  CREATED ORIGINAL TEST.

WITH REPORT; USE REPORT;

PROCEDURE C34014H IS

     PACKAGE P IS
          TYPE T IS RANGE -100 .. 100;
          FUNCTION F RETURN T;
     END P;
     USE P;

     PACKAGE BODY P IS
          FUNCTION F RETURN T IS
          BEGIN
               RETURN T (IDENT_INT (1));
          END F;
     END P;

BEGIN
     TEST ("C34014H", "CHECK THAT A DERIVED SUBPROGRAM IS VISIBLE " &
                      "AND FURTHER DERIVABLE UNDER APPROPRIATE " &
                      "CIRCUMSTANCES.  CHECK WHEN THE DERIVED " &
                      "SUBPROGRAM IS IMPLICITLY DECLARED IN THE " &
                      "PRIVATE PART OF A PACKAGE AFTER AN EXPLICIT " &
                      "DECLARATION OF A HOMOGRAPHIC SUBPROGRAM IN " &
                      "THE VISIBLE PART");

     -----------------------------------------------------------------

     COMMENT ("NEW SUBPROGRAM DECLARED BY SUBPROGRAM DECLARATION");

     DECLARE

          PACKAGE Q IS
               TYPE QT IS PRIVATE;
               C2 : CONSTANT QT;
               FUNCTION F RETURN QT;
               TYPE QR1 IS
                    RECORD
                         C : QT := F;
                    END RECORD;
          PRIVATE
               TYPE QT IS NEW T;
               C2 : CONSTANT QT := 2;
               TYPE QR2 IS
                    RECORD
                         C : QT := F;
                    END RECORD;
               TYPE QS IS NEW QT;
          END Q;
          USE Q;

          PACKAGE BODY Q IS
               FUNCTION F RETURN QT IS
               BEGIN
                    RETURN QT (IDENT_INT (2));
               END F;

               PACKAGE R IS
                    X : QR1;
                    Y : QR2;
                    Z : QS := F;
               END R;
               USE R;
          BEGIN
               IF X.C /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT VISIBLE - SUBPROG " &
                            "DECL - 1");
               END IF;

               IF Y.C /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT VISIBLE - SUBPROG " &
                            "DECL - 2");
               END IF;

               IF Z /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT DERIVED - SUBPROG " &
                            "DECL - 1");
               END IF;
          END Q;

          PACKAGE R IS
               Y : QT := F;
               TYPE RT IS NEW QT;
               Z : RT := F;
          END R;
          USE R;

     BEGIN
          IF Y /= C2 THEN
               FAILED ("NEW SUBPROGRAM NOT VISIBLE - SUBPROG DECL - 3");
          END IF;

          IF Z /= RT (C2) THEN
               FAILED ("NEW SUBPROGRAM NOT DERIVED - SUBPROG DECL - 2");
          END IF;
     END;

     -----------------------------------------------------------------

     COMMENT ("NEW SUBPROGRAM DECLARED BY RENAMING");

     DECLARE

          PACKAGE Q IS
               TYPE QT IS PRIVATE;
               C2 : CONSTANT QT;
               FUNCTION G RETURN QT;
               FUNCTION F RETURN QT RENAMES G;
               TYPE QR1 IS
                    RECORD
                         C : QT := F;
                    END RECORD;
          PRIVATE
               TYPE QT IS NEW T;
               C2 : CONSTANT QT := 2;
               TYPE QR2 IS
                    RECORD
                         C : QT := F;
                    END RECORD;
               TYPE QS IS NEW QT;
          END Q;
          USE Q;

          PACKAGE BODY Q IS
               FUNCTION G RETURN QT IS
               BEGIN
                    RETURN QT (IDENT_INT (2));
               END G;

               PACKAGE R IS
                    X : QR1;
                    Y : QR2;
                    Z : QS := F;
               END R;
               USE R;
          BEGIN
               IF X.C /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT VISIBLE - RENAMING - " &
                            "1");
               END IF;

               IF Y.C /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT VISIBLE - RENAMING - " &
                            "2");
               END IF;

               IF Z /= 2 THEN
                    FAILED ("NEW SUBPROGRAM NOT DERIVED - RENAMING - " &
                            "1");
               END IF;
          END Q;

          PACKAGE R IS
               Y : QT := F;
               TYPE RT IS NEW QT;
               Z : RT := F;
          END R;
          USE R;

     BEGIN
          IF Y /= C2 THEN
               FAILED ("NEW SUBPROGRAM NOT VISIBLE - RENAMING - 3");
          END IF;

          IF Z /= RT (C2) THEN
               FAILED ("NEW SUBPROGRAM NOT DERIVED - RENAMING - 2");
          END IF;
     END;

     -----------------------------------------------------------------

     RESULT;
END C34014H;
