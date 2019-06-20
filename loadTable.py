import numpy as np
import scipy.io as sio
convTable = np.zeros((2, 9)).astype(object)
for i in range(2):  # raidus
    for j in range(9):  # subdivision
        table_path = "./convIndex/radius" + str(i + 1) + "/subdivision" + str(j)
        table = sio.loadmat(table_path)
        # For original and No-rotation 1 kernel
        table = np.array(table['lookupTable_Patchparam1']).astype(np.int32)
        convTable[i, j] = table - 1

poolRef = sio.loadmat("./poolIndex/poolingIndex")['product'].astype(np.int32)
poolRef = poolRef - 1

poolTable = []
for i in range(8):  # subdivision
    buf = poolRef[0:4 ** i, 0]
    buf = np.reshape(buf, [4 ** i])
    table = []
    for j in range(20):
        table = np.concatenate((table, buf))
        buf = buf + 4 ** (i + 1)
    table = table.astype(int)
    poolTable.append(table)
poolTable = np.asarray(poolTable)