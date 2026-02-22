import matplotlib.pyplot as plt
import yaml
import random
import pandas as pd
import sys

scoring_profile = {}
mc_run = []

with open("decisions.yaml") as f:
    data = yaml.load(f, Loader=yaml.SafeLoader)



a = 'option_a'
b = 'option_b'
vl = 'values'

qry = data["decisions"]

# tr_p = 0.1
# bl_p = 0.8
# or_p = 0.4
# hr_p = 0.3
# l_p = 0.6
# mr_p = 0.2
# js_p = 0.3


# pbtable =  {"truth"    : tr_p, 
#             "balance"  : bl_p,
#             "order"    : or_p,
#             "harmony"  : hr_p, 
#             "law"      : l_p,
#             "morality" : mr_p, 
#             "justice"  : js_p,}

# chtable =  {"truth"    : 1, 
#             "balance"  : 1,
#             "order"    : 1,
#             "harmony"  : -1, 
#             "law"      : -1,
#             "morality" : 1, 
#             "justice"  : -1}

# for q in range(len(qry)):
#     chance = random.random()
#     for x in [a,b]:
#         valgd = qry[q][x][vl]
#         for vlg in valgd:
#             # get probs
#             pb = pbtable[vlg]
#             if chance < pb:
#                 valgd[vlg] += chtable[vlg]

# data["decisions"][n] # question access
# data["decisions"][0][a] # text / outcome access
# data["decisions"][0][a][v] # values access

# population = 10
# iterations = 20

counts = {0:0,
          1:0,
          2:0,
          3:0,
          -1:0,
          -2:0,
          -3:0,
          }

for q in range(len(qry)):
    for x in [a,b]:
        query = qry[q][x][vl]
        if "balance" in query:
            counts[query["balance"]] += 1


population = 100
iterations = 5000
holder = {"truth": 0, 
            "balance"  : 0,
            "order"    : 0,
            "harmony"  : 0, 
            "law"      : 0,
            "morality" : 0, 
            "justice"  : 0,}

for iters in range(iterations):
    for pop in range(population):
        pop_vals = {"truth": 0, 
            "balance"  : 0,
            "order"    : 0,
            "harmony"  : 0, 
            "law"      : 0,
            "morality" : 0, 
            "justice"  : 0,}
        for q in range(len(qry)):
            choice = random.choice([a,b])
            valuesgd = qry[q][choice][vl]
            for k,v in valuesgd.items():
                pop_vals[k] += v

        scoring_profile[pop] = pop_vals

    d = pd.DataFrame.from_dict(scoring_profile,orient="index")
    mc_run.append(d)
# print("Balance Score Counts")
# print(counts)
avgd = pd.concat(mc_run).groupby(level=0).mean()
# maxs = []
# mins = []

# for df in range(len(mc_run)):
#     tp = []
#     tp.append(mc_run[df].max())
#     maxs.append(tp)
#     tp = []
#     tp.append(mc_run[df].min())
#     mins.append(tp)
    
# run_max = []

# a = list(zip(maxs))
# run_max = []

# a,b,d,c,e,f,g = list(zip(mins))
# run_min = [min(a),min(b),min(c),min(d),min(e),min(f),min(g)]
# vs = list(holder.keys())

avgd.boxplot()
# plt.plot(vs,run_max)
# plt.plot(vs,run_min)
plt.show()
# print(pd.DataFrame(avgd).mean())
# rankings = list(pd.DataFrame(avgd).mean().rank())
# rankings = list(map(int,rankings))

