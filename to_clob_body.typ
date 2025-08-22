
CREATE OR REPLACE TYPE BODY to_clob_agg_type IS

  STATIC FUNCTION ODCIAggregateInitialize(sctx IN OUT to_clob_agg_type) RETURN NUMBER IS
  BEGIN
    sctx := to_clob_agg_type(NULL);
    RETURN ODCIConst.Success;
  END;

  MEMBER FUNCTION ODCIAggregateIterate(self IN OUT to_clob_agg_type, value IN VARCHAR2) RETURN NUMBER IS
  BEGIN
    IF self.total IS NULL THEN
      DBMS_LOB.CREATETEMPORARY(self.total, TRUE);
      DBMS_LOB.APPEND(self.total, value);
    ELSE
      DBMS_LOB.APPEND(self.total, ',' || value);   --If you need a concatenate with enter you can pu chr(13) despit the ','
    END IF;
    RETURN ODCIConst.Success;
  END;

  MEMBER FUNCTION ODCIAggregateTerminate(self IN to_clob_agg_type, returnValue OUT CLOB, flags IN NUMBER) RETURN NUMBER IS
  BEGIN
    returnValue := self.total;
    RETURN ODCIConst.Success;
  END;

  MEMBER FUNCTION ODCIAggregateMerge(self IN OUT to_clob_agg_type, ctx2 IN to_clob_agg_type) RETURN NUMBER IS
  BEGIN
    IF ctx2.total IS NOT NULL THEN
      IF self.total IS NULL THEN
        self.total := ctx2.total;
      ELSE
        DBMS_LOB.APPEND(self.total, ctx2.total);
      END IF;
    END IF;
    RETURN ODCIConst.Success;
  END;

END;
/

