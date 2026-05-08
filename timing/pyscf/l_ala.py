import time
import sys
from pyscf import gto, dft, grad
from pyscf.dft import gen_grid


start = time.perf_counter()
mol = gto.Mole()


mol_name = "l-alanine"
mol.atom = '''
C     -1.072478    0.898301   -0.510173
C     -0.335641   -0.378976   -0.152239
C      1.121573   -0.154011   -0.004149
O      1.642993   -0.367208    1.139968
O      1.893455    0.276167   -1.081197
N     -0.866181   -0.817389    1.118520
H     -0.849535    1.198815   -1.541349
H     -2.157620    0.703190   -0.403082
H     -0.710299    1.679119    0.204474
H     -0.547929   -1.105873   -0.947962
H      2.906571    0.255865   -0.948338
H     -0.343734   -0.335205    1.893232
H     -0.681176   -1.852796    1.232295
'''
mol.basis = "6-31g*"
mol.cart = True
mol.charge = 0
mol.spin = 0
mol.verbose = 5 
mol.build()


mf = dft.RKS(mol)
mf.xc = "b3lyp"
mf.max_cycle = 128
mf.conv_tol = 1e-16
mf.direct_scf_tol = 1e-17
# SG-1グリッドを手動設定
mf.grids.atom_grid = {
    'H': (50, 194),   # (ラジアル点数, 角度点数)
    'C': (50, 194),
    'N': (50, 194),
    'O': (50, 194),
    'Cl': (50, 194),
    # 必要な元素を追加
}
mf.grids.prune = dft.gen_grid.sg1_prune  # SG-1のpruning

mf.kernel()


end1 = time.perf_counter()
print("SCF収束まで")
print('{:.2f}'.format(end1-start))

mg = grad.rks.Grad(mf)
mg.kernel()

print(mg)

end2 = time.perf_counter()
print("gradient")
print('{:.2f}'.format(end2-end1))
