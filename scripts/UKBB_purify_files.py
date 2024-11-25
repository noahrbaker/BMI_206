import csv
import gzip
import os

def uncompress_files():
    """Convert .tsv.bgz files into tsv files."""
    # List all files in the current directory
    files = os.listdir('/Users/cthompson4/Desktop/BMI206/Project/Project_Data')
    bgz_files = list(filter(lambda file: file.endswith('.bgz'), files))
    bgz_files = ['30020_raw.gwas.imputed_v3.both_sexes.tsv.bgz']
    for file in bgz_files:
        fp = '/Users/cthompson4/Desktop/BMI206/Project/Project_Data/' + file
        print(f'STARTING FILE: {fp}')
        o_filename = file.removesuffix('.bgz')
        i_file = gzip.GzipFile(fp)
        o_filename = '/Users/cthompson4/Desktop/BMI206/Project/Project_Data/' + o_filename
        o_file = open(o_filename, "wb")

        for line in i_file:
            o_file.write(i_file.readline())

        i_file.close()
        o_file.close()
        print(f'COMPLETED FILE: {o_file}')

def column_purify():
    """
    Provided rows:
        variant
        minor_allele
        minor_AF
        low_confidence_variant
        n_complete_samples
        AC
        ytx
        beta
        se
        tstat
        pval

    Needed data:
        SNP  # row 0
        A1   # component of row 0
        A2   # component of row 0
        BETA # row 7
        SE   # row 8
    """

    files = os.listdir('/Users/cthompson4/Desktop/BMI206/Project/Project_Data')
    tsv_files = list(filter(lambda file: file.endswith('.tsv'), files))
    for file in tsv_files:
        i_filepath = '/Users/cthompson4/Desktop/BMI206/Project/Project_Data/' + file
        o_filepath = i_filepath.removesuffix('.tsv')
        o_filepath += '_purified.tsv'
        print(f'STARTING FILE: {i_filepath}')

        with open(o_filepath, 'w') as o_fp:
            tsv_output = csv.writer(o_fp, delimiter='\t')
            header_row = ['SNP', 'A1', 'A2', 'BETA', 'SE']
            tsv_output.writerow(header_row)
            with open(i_filepath) as fp:
                lines = [line.rstrip() for line in fp]
                for line in lines:
                    line_list = line.split('\t')
                    variant_splice = line_list[0].split(':')
                    a1 = variant_splice[2]
                    a2 = variant_splice[3]
                    new_row = [line_list[0], a1, a2, float(line_list[7]), float(line_list[8])]
                    tsv_output.writerow(new_row)
        print(f'COMPLETED FILE {o_filepath}')