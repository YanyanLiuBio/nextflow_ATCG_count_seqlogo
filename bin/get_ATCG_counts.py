#!/usr/bin/env python3

import pandas as pd
import sys
import os

run_id = sys.argv[1]
outpath = run_id +".ATCG_counts_summary.csv"

paths = [path for path in sorted(os.listdir('.')) if path.endswith('.txt')]
df = pd.DataFrame([], columns = ['pair_id','position', 'A', 'C', 'G', 'T', "N", "A_pct","C_pct","G_pct","T_pct", "N_pct"])




for path in paths:
    
    pair_id = path.replace('.txt','')
    fq = pd.read_csv(path, names = ['seq'])
    nread = len(fq.index)
    data = [[n+1] + fq.seq.str[n].value_counts()[['A', 'C', 'G', 'T']].tolist() for n in range(12)]
    
    data_df = pd.DataFrame(data, columns=['position', 'A', 'C', 'G', 'T'])
    data_df["pair_id"] = pair_id
    
    data_df["A_pct"] = round(data_df["A"]/nread, 6)*100
    data_df["C_pct"] = round(data_df["C"]/nread, 6)*100
    data_df["G_pct"] = round(data_df["G"]/nread, 6)*100
    data_df["T_pct"] = round(data_df["T"]/nread, 6)*100
    data_df["N"] = nread - ( data_df["A"] + data_df["C"] + data_df["G"] + data_df["T"])
    data_df["N_pct"] = round(data_df['N']/nread, 6)*100

    df = pd.concat([df, data_df])
    

pd.DataFrame(df, columns = ['pair_id','position', 'A', 'C', 'G', 'T', "N", "A_pct","C_pct","G_pct","T_pct", "N_pct"] ).to_csv(outpath, index = False)
