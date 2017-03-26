import Accelerate


//vectors and scalar
var v = [1.0, 3.0]
var s = 3.0
var vsresult = [Double](repeating : 0.0, count : v.count)

vDSP_vsaddD(v, 1, &s, &vsresult, 1, vDSP_Length(v.count))
vsresult

vDSP_vsmulD(vsresult, 1, &s, &vsresult, 1, vDSP_Length(v.count))
vsresult

vDSP_vsdivD(vsresult, 1, &s, &vsresult, 1, vDSP_Length(v.count))
vsresult

//vectors and vectors
var v1 = [2.0, 5.0]
var v2 = [3.0, 4.0]
var vvresult = [Double](repeating : 0.0, count : 2)

vDSP_vaddD(v1, 1, v2, 1, &vvresult, 1, vDSP_Length(v1.count))
vvresult

vDSP_vmulD(v1, 1, v2, 1, &vvresult, 1,vDSP_Length(v1.count))
vvresult

vDSP_vdivD(v1, 1, v2, 1,&vvresult, 1, vDSP_Length(v1.count))
vvresult

//dot product
var v3 = [1.0, 2.0]
var v4 = [3.0, 4.0]
var dpresult = 0.0
vDSP_dotprD(v3, 1, v4, 1, &dpresult, vDSP_Length(v3.count))
dpresult

//matrix multiplication
var m1 = [3.0, 2.0, 4.0, 5.0, 6.0, 7.0]
var m2 = [10.0, 20.0, 30.0, 30.0, 40.0, 50.0]
var mresult = [Double](repeating: 0.0, count: 9)
vDSP_mmulD(m1, 1, m2, 1, &mresult, 1, 3, 3, 2)
mresult

//matrix transpose
var t = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
var mtresult = [Double](repeating : 0.0, count : t.count)
vDSP_mtransD(t, 1, &mtresult, 1, 3, 2)
mtresult

//matrix inversion
func invert(matrix : [Double]) -> [Double] {
    var inMatrix = matrix
    var pivot : __CLPK_integer = 0
    var workspace = 0.0
    var error : __CLPK_integer = 0
    
    var N = __CLPK_integer(sqrt(Double(matrix.count)))
    dgetrf_(&N, &N, &inMatrix, &N, &pivot, &error)
    
    if error != 0 {
        return inMatrix
    }
    
    dgetri_(&N, &inMatrix, &N, &pivot, &workspace, &N, &error)
    return inMatrix
}

var m = [1.0, 2.0, 3.0, 4.0]
invert(matrix: m)
