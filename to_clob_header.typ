CREATE OR REPLACE TYPE to_clob_agg_type AS OBJECT (
  total CLOB,

  STATIC FUNCTION ODCIAggregateInitialize(sctx IN OUT to_clob_agg_type) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateIterate(self IN OUT to_clob_agg_type, value IN VARCHAR2) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateTerminate(self IN to_clob_agg_type, returnValue OUT CLOB, flags IN NUMBER) RETURN NUMBER,
  MEMBER FUNCTION ODCIAggregateMerge(self IN OUT to_clob_agg_type, ctx2 IN to_clob_agg_type) RETURN NUMBER
);
/
