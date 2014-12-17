CREATE TABLE bounding_box (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                data BLOB NOT NULL,
                run_slice_id INTEGER NOT NULL,
                first_spectrum_id INTEGER NOT NULL,
                last_spectrum_id INTEGER NOT NULL,
                FOREIGN KEY (run_slice_id) REFERENCES run_slice (id),
                FOREIGN KEY (first_spectrum_id) REFERENCES spectrum (id),
                FOREIGN KEY (last_spectrum_id) REFERENCES spectrum (id)
);

CREATE TABLE bounding_box_rtree (
                id INTEGER NOT NULL,
                min_mz REAL NOT NULL,
                max_mz REAL NOT NULL,
                min_time REAL NOT NULL,
                max_time REAL NOT NULL,
                PRIMARY KEY (id)
);

CREATE TABLE chromatogram (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                activation_type TEXT(10) NOT NULL,
                data_points BLOB NOT NULL,
                param_tree TEXT NOT NULL,
                precursor TEXT,
                product TEXT,
                shared_param_tree_id INTEGER,
                run_id INTEGER NOT NULL,
                data_processing_id INTEGER,
                data_encoding_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (run_id) REFERENCES run (id),
                FOREIGN KEY (data_processing_id) REFERENCES data_processing (id),
                FOREIGN KEY (data_encoding_id) REFERENCES data_encoding (id)
);

CREATE TABLE cv (
                id TEXT(10) NOT NULL,
                full_name TEXT NOT NULL,
                version TEXT(10),
                uri TEXT NOT NULL,
                PRIMARY KEY (id)
);

CREATE TABLE cv_term (
                accession TEXT NOT NULL,
                name TEXT NOT NULL,
                unit_accession TEXT,
                cv_id TEXT(10) NOT NULL,
                PRIMARY KEY (accession),
                FOREIGN KEY (unit_accession) REFERENCES cv_unit (accession),
                FOREIGN KEY (cv_id) REFERENCES cv (id)
);

CREATE TABLE cv_unit (
                accession TEXT NOT NULL,
                name TEXT NOT NULL,
                cv_id TEXT(10) NOT NULL,
                PRIMARY KEY (accession),
                FOREIGN KEY (cv_id) REFERENCES cv (id)
);

CREATE TABLE data_encoding (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                mode TEXT(10) NOT NULL,
                compression TEXT,
                byte_order TEXT(13) NOT NULL,
                param_tree TEXT NOT NULL
);

CREATE TABLE data_processing (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL
);

CREATE TABLE instrument_configuration (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                param_tree TEXT NOT NULL,
                component_list TEXT NOT NULL,
                shared_param_tree_id INTEGER,
                software_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (software_id) REFERENCES software (id)
);

CREATE TABLE mzdb (
                version TEXT(10) NOT NULL,
                creation_timestamp TEXT NOT NULL,
                file_content TEXT NOT NULL,
                contact TEXT NOT NULL,
                param_tree TEXT NOT NULL,
                PRIMARY KEY (version)
);

CREATE TABLE param_tree_schema (
                name TEXT NOT NULL,
                type TEXT(10) NOT NULL,
                schema TEXT NOT NULL,
                PRIMARY KEY (name)
);

CREATE TABLE processing_method (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                number INTEGER NOT NULL,
                param_tree TEXT NOT NULL,
                shared_param_tree_id INTEGER,
                data_processing_id INTEGER NOT NULL,
                software_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (data_processing_id) REFERENCES data_processing (id),
                FOREIGN KEY (software_id) REFERENCES software (id)
);

CREATE TABLE run (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                start_timestamp TEXT,
                param_tree TEXT,
                shared_param_tree_id INTEGER,
                sample_id INTEGER,
                default_instrument_config_id INTEGER NOT NULL,
                default_source_file_id INTEGER,
                default_scan_processing_id INTEGER NOT NULL,
                default_chrom_processing_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (sample_id) REFERENCES sample (id),
                FOREIGN KEY (default_instrument_config_id) REFERENCES instrument_configuration (id),
                FOREIGN KEY (default_source_file_id) REFERENCES source_file (id),
                FOREIGN KEY (default_scan_processing_id) REFERENCES data_processing (id),
                FOREIGN KEY (default_chrom_processing_id) REFERENCES data_processing (id)
);

CREATE TABLE run_slice (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                ms_level INTEGER NOT NULL,
                number INTEGER NOT NULL,
                begin_mz REAL NOT NULL,
                end_mz REAL NOT NULL,
                param_tree TEXT,
                run_id INTEGER NOT NULL,
                FOREIGN KEY (run_id) REFERENCES run (id)
);

CREATE TABLE sample (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                param_tree TEXT,
                shared_param_tree_id INTEGER,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id)
);

CREATE TABLE scan_settings (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                param_tree TEXT,
                shared_param_tree_id INTEGER,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id)
);

CREATE TABLE shared_param_tree (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                data TEXT NOT NULL,
                schema_name TEXT NOT NULL,
                FOREIGN KEY (schema_name) REFERENCES param_tree_schema (name)
);

CREATE TABLE software (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                version TEXT NOT NULL,
                param_tree TEXT NOT NULL,
                shared_param_tree_id INTEGER,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id)
);

CREATE TABLE source_file (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                location TEXT NOT NULL,
                param_tree TEXT NOT NULL,
                shared_param_tree_id INTEGER,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id)
);

CREATE TABLE source_file_scan_settings_map (
                scan_settings_id INTEGER NOT NULL,
                source_file_id INTEGER NOT NULL,
                PRIMARY KEY (scan_settings_id, source_file_id)
);

CREATE TABLE spectrum (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                initial_id INTEGER NOT NULL,
                title TEXT NOT NULL,
                cycle INTEGER NOT NULL,
                time REAL NOT NULL,
                ms_level INTEGER NOT NULL,
                activation_type TEXT(10) NOT NULL,
                tic REAL NOT NULL,
                base_peak_mz REAL NOT NULL,
                base_peak_intensity REAL NOT NULL,
                main_precursor_mz REAL,
                main_precursor_charge INTEGER,
                data_points_count INTEGER NOT NULL,
                param_tree TEXT NOT NULL,
                scan_list TEXT,
                precursor_list TEXT,
                product_list TEXT,
                shared_param_tree_id INTEGER,
                instrument_configuration_id INTEGER,
                source_file_id INTEGER,
                run_id INTEGER NOT NULL,
                data_processing_id INTEGER,
                data_encoding_id INTEGER NOT NULL,
                bb_first_spectrum_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (instrument_configuration_id) REFERENCES instrument_configuration (id),
                FOREIGN KEY (source_file_id) REFERENCES source_file (id),
                FOREIGN KEY (run_id) REFERENCES run (id),
                FOREIGN KEY (data_processing_id) REFERENCES data_processing (id),
                FOREIGN KEY (data_encoding_id) REFERENCES data_encoding (id),
                FOREIGN KEY (bb_first_spectrum_id) REFERENCES spectrum (id)
);

CREATE TABLE table_param_tree_schema (
                table_name TEXT NOT NULL,
                schema_name TEXT NOT NULL,
                PRIMARY KEY (table_name),
                FOREIGN KEY (schema_name) REFERENCES param_tree_schema (name)
);

CREATE TABLE target (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                param_tree TEXT NOT NULL,
                shared_param_tree_id INTEGER,
                scan_settings_id INTEGER NOT NULL,
                FOREIGN KEY (shared_param_tree_id) REFERENCES shared_param_tree (id),
                FOREIGN KEY (scan_settings_id) REFERENCES scan_settings (id)
);

CREATE TABLE user_term (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                type TEXT NOT NULL,
                unit_accession TEXT,
                FOREIGN KEY (unit_accession) REFERENCES cv_unit (accession)
);

CREATE UNIQUE INDEX spectrum_initial_id_idx ON spectrum (initial_id ASC,run_id ASC);

CREATE INDEX spectrum_ms_level_idx ON spectrum (ms_level ASC,run_id ASC);

CREATE UNIQUE INDEX run_name_idx ON run (name);

CREATE UNIQUE INDEX run_slice_mz_range_idx ON run_slice (begin_mz ASC,end_mz ASC,ms_level ASC,run_id ASC);

CREATE INDEX bounding_box_first_spectrum_idx ON bounding_box (first_spectrum_id ASC);

CREATE INDEX bounding_box_run_slice_idx ON bounding_box (run_slice_id ASC);

CREATE UNIQUE INDEX controlled_vocabulary_full_name_idx ON cv (full_name);

CREATE INDEX controlled_vocabulary_uri_idx ON cv (uri);

CREATE UNIQUE INDEX source_file_name_idx ON source_file (name);

CREATE UNIQUE INDEX sample_name_idx ON sample (name);

CREATE UNIQUE INDEX software_name_idx ON software (name);

CREATE UNIQUE INDEX instrument_configuration_name_idx ON instrument_configuration (name);

CREATE UNIQUE INDEX processing_method_number_idx ON processing_method (number ASC);

CREATE UNIQUE INDEX data_processing_name_idx ON data_processing (name);

CREATE UNIQUE INDEX chromatogram_name_idx ON chromatogram (name);

CREATE UNIQUE INDEX cv_term_name_idx ON cv_term (name ASC);

CREATE UNIQUE INDEX user_term_name_idx ON user_term (name ASC);

CREATE UNIQUE INDEX cv_unit_name_idx ON cv_unit (name ASC);

