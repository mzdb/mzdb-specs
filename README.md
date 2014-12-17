mzdb-specs
==========

Specifications of the mzDB file format.

The main document describing the mzDB specifications is named "mzDB_x.x.x_specifications.docx", "x.x.x" being the version number of the corresponding specifications. This document is also provided in the PDF format.
For each version of the specifications, a dedicated folder has been created.

This folder contains some other documents for developers who prefer to have access to database diagram or script:
* mzDB_x.x.x_schema_diagram.architect => the PowerArchitect diagram of the SQLite schema. The PowerArchitect software can be downloaded from its Google Code page: https://code.google.com/p/power-architect/
* mzDB_x.x.x_schema_documentation.html => the HTML documentation of the schema (as exported from PowerArchitect)
* mzDB_x.x.x_schema_picture.pdf => the picture of the schema in PDF format (as exported from PowerArchitect)
* mzDB_x.x.x_schema_script.sql => the SQLite script used for mzDB schema initialization

Benchmarks and use cases
========================
This work and  has been recently published in the <a href="http://www.mcponline.org/content/early/2014/12/11/mcp.O114.039115.abstract">MCP journal</a>:

Bouyssie D, Dubois M, Nasso S, Gonzalez de Peredo A, Burlet-Schiltz O, Aebersold R, Monsarrat B. mzDB: a file format using multiple indexing strategies  for the efficient analysis of large LC-MS/MS and SWATH-MS datasets. Mol Cell Proteomics. 2014 Dec 11

In this paper, the performance of mzDB is benchmarked in several reading modes against the mzML and mz5 file formats.
