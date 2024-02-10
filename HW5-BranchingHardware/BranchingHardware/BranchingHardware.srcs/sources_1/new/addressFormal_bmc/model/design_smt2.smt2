; SMT-LIBv2 description generated by Yosys 0.37+90 (git sha1 16ff3e0a3, clang 15.0.0 -fPIC -Os)
; yosys-smt2-module BranchAddressGen
(declare-sort |BranchAddressGen_s| 0)
(declare-fun |BranchAddressGen_is| (|BranchAddressGen_s|) Bool)
(declare-fun |BranchAddressGen#0| (|BranchAddressGen_s|) (_ BitVec 32)) ; \sourceReg1
; yosys-smt2-input sourceReg1 32
; yosys-smt2-wire sourceReg1 32
; yosys-smt2-witness {"offset": 0, "path": ["\\sourceReg1"], "smtname": "sourceReg1", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGen_n sourceReg1| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#0| state))
(declare-fun |BranchAddressGen#1| (|BranchAddressGen_s|) (_ BitVec 32)) ; \programCounter
; yosys-smt2-input programCounter 32
; yosys-smt2-wire programCounter 32
; yosys-smt2-witness {"offset": 0, "path": ["\\programCounter"], "smtname": "programCounter", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGen_n programCounter| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#1| state))
(declare-fun |BranchAddressGen#2| (|BranchAddressGen_s|) (_ BitVec 32)) ; \iTypeImmd
(define-fun |BranchAddressGen#3| ((state |BranchAddressGen_s|)) (_ BitVec 32) (bvadd (|BranchAddressGen#2| state) (|BranchAddressGen#0| state))) ; \jalr
; yosys-smt2-output jalr 32
; yosys-smt2-wire jalr 32
(define-fun |BranchAddressGen_n jalr| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#3| state))
(declare-fun |BranchAddressGen#4| (|BranchAddressGen_s|) (_ BitVec 32)) ; \jTypeImmd
(define-fun |BranchAddressGen#5| ((state |BranchAddressGen_s|)) (_ BitVec 32) (bvadd (|BranchAddressGen#4| state) (|BranchAddressGen#1| state))) ; \jal
; yosys-smt2-output jal 32
; yosys-smt2-wire jal 32
(define-fun |BranchAddressGen_n jal| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#5| state))
; yosys-smt2-input jTypeImmd 32
; yosys-smt2-wire jTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\jTypeImmd"], "smtname": "jTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGen_n jTypeImmd| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#4| state))
; yosys-smt2-input iTypeImmd 32
; yosys-smt2-wire iTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\iTypeImmd"], "smtname": "iTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGen_n iTypeImmd| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#2| state))
(declare-fun |BranchAddressGen#6| (|BranchAddressGen_s|) (_ BitVec 32)) ; \bTypeImmd
(define-fun |BranchAddressGen#7| ((state |BranchAddressGen_s|)) (_ BitVec 32) (bvadd (|BranchAddressGen#6| state) (|BranchAddressGen#1| state))) ; \branch
; yosys-smt2-output branch 32
; yosys-smt2-wire branch 32
(define-fun |BranchAddressGen_n branch| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#7| state))
; yosys-smt2-input bTypeImmd 32
; yosys-smt2-wire bTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\bTypeImmd"], "smtname": "bTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGen_n bTypeImmd| ((state |BranchAddressGen_s|)) (_ BitVec 32) (|BranchAddressGen#6| state))
(define-fun |BranchAddressGen_a| ((state |BranchAddressGen_s|)) Bool true)
(define-fun |BranchAddressGen_u| ((state |BranchAddressGen_s|)) Bool true)
(define-fun |BranchAddressGen_i| ((state |BranchAddressGen_s|)) Bool true)
(define-fun |BranchAddressGen_h| ((state |BranchAddressGen_s|)) Bool true)
(define-fun |BranchAddressGen_t| ((state |BranchAddressGen_s|) (next_state |BranchAddressGen_s|)) Bool true) ; end of module BranchAddressGen
; yosys-smt2-module BranchAddressGenFormal
(declare-sort |BranchAddressGenFormal_s| 0)
(declare-fun |BranchAddressGenFormal_is| (|BranchAddressGenFormal_s|) Bool)
(declare-fun |BranchAddressGenFormal#0| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \sourceReg1
; yosys-smt2-input sourceReg1 32
; yosys-smt2-wire sourceReg1 32
; yosys-smt2-witness {"offset": 0, "path": ["\\sourceReg1"], "smtname": "sourceReg1", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGenFormal_n sourceReg1| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#0| state))
(declare-fun |BranchAddressGenFormal#1| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \programCounter
; yosys-smt2-input programCounter 32
; yosys-smt2-wire programCounter 32
; yosys-smt2-witness {"offset": 0, "path": ["\\programCounter"], "smtname": "programCounter", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGenFormal_n programCounter| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#1| state))
; yosys-smt2-cell BranchAddressGen BranchAddressGen
; yosys-smt2-witness {"path": ["\\BranchAddressGen"], "smtname": "BranchAddressGen", "type": "cell"}
(declare-fun |BranchAddressGenFormal#2| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \jalr
(declare-fun |BranchAddressGenFormal#3| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \jal
(declare-fun |BranchAddressGenFormal#4| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \branch
(declare-fun |BranchAddressGenFormal_h BranchAddressGen| (|BranchAddressGenFormal_s|) |BranchAddressGen_s|)
; yosys-smt2-output jalr 32
; yosys-smt2-wire jalr 32
(define-fun |BranchAddressGenFormal_n jalr| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#2| state))
; yosys-smt2-output jal 32
; yosys-smt2-wire jal 32
(define-fun |BranchAddressGenFormal_n jal| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#3| state))
(declare-fun |BranchAddressGenFormal#5| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \jTypeImmd
; yosys-smt2-input jTypeImmd 32
; yosys-smt2-wire jTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\jTypeImmd"], "smtname": "jTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGenFormal_n jTypeImmd| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#5| state))
(declare-fun |BranchAddressGenFormal#6| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \iTypeImmd
; yosys-smt2-input iTypeImmd 32
; yosys-smt2-wire iTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\iTypeImmd"], "smtname": "iTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGenFormal_n iTypeImmd| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#6| state))
; yosys-smt2-output branch 32
; yosys-smt2-wire branch 32
(define-fun |BranchAddressGenFormal_n branch| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#4| state))
(declare-fun |BranchAddressGenFormal#7| (|BranchAddressGenFormal_s|) (_ BitVec 32)) ; \bTypeImmd
; yosys-smt2-input bTypeImmd 32
; yosys-smt2-wire bTypeImmd 32
; yosys-smt2-witness {"offset": 0, "path": ["\\bTypeImmd"], "smtname": "bTypeImmd", "smtoffset": 0, "type": "input", "width": 32}
(define-fun |BranchAddressGenFormal_n bTypeImmd| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (|BranchAddressGenFormal#7| state))
(define-fun |BranchAddressGenFormal#8| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (bvadd (|BranchAddressGenFormal#0| state) (|BranchAddressGenFormal#6| state))) ; $add$BranchAddressGenFormal.sv:56$9_Y
(define-fun |BranchAddressGenFormal#9| ((state |BranchAddressGenFormal_s|)) Bool (= (|BranchAddressGenFormal#2| state) (|BranchAddressGenFormal#8| state))) ; $eq$BranchAddressGenFormal.sv:56$10_Y
; yosys-smt2-assert 0 $assert$BranchAddressGenFormal.sv:53$8 BranchAddressGenFormal.sv:53.50-56.43
(define-fun |BranchAddressGenFormal_a 0| ((state |BranchAddressGenFormal_s|)) Bool (or (|BranchAddressGenFormal#9| state) (not true))) ; $assert$BranchAddressGenFormal.sv:53$8
(define-fun |BranchAddressGenFormal#10| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (bvadd (|BranchAddressGenFormal#1| state) (|BranchAddressGenFormal#7| state))) ; $add$BranchAddressGenFormal.sv:53$6_Y
(define-fun |BranchAddressGenFormal#11| ((state |BranchAddressGenFormal_s|)) Bool (= (|BranchAddressGenFormal#4| state) (|BranchAddressGenFormal#10| state))) ; $eq$BranchAddressGenFormal.sv:53$7_Y
; yosys-smt2-assert 1 $assert$BranchAddressGenFormal.sv:50$5 BranchAddressGenFormal.sv:50.46-53.49
(define-fun |BranchAddressGenFormal_a 1| ((state |BranchAddressGenFormal_s|)) Bool (or (|BranchAddressGenFormal#11| state) (not true))) ; $assert$BranchAddressGenFormal.sv:50$5
(define-fun |BranchAddressGenFormal#12| ((state |BranchAddressGenFormal_s|)) (_ BitVec 32) (bvadd (|BranchAddressGenFormal#1| state) (|BranchAddressGenFormal#5| state))) ; $add$BranchAddressGenFormal.sv:50$3_Y
(define-fun |BranchAddressGenFormal#13| ((state |BranchAddressGenFormal_s|)) Bool (= (|BranchAddressGenFormal#3| state) (|BranchAddressGenFormal#12| state))) ; $eq$BranchAddressGenFormal.sv:50$4_Y
; yosys-smt2-assert 2 $assert$BranchAddressGenFormal.sv:48$2 BranchAddressGenFormal.sv:48.18-50.45
(define-fun |BranchAddressGenFormal_a 2| ((state |BranchAddressGenFormal_s|)) Bool (or (|BranchAddressGenFormal#13| state) (not true))) ; $assert$BranchAddressGenFormal.sv:48$2
(define-fun |BranchAddressGenFormal_a| ((state |BranchAddressGenFormal_s|)) Bool (and
  (|BranchAddressGenFormal_a 0| state)
  (|BranchAddressGenFormal_a 1| state)
  (|BranchAddressGenFormal_a 2| state)
  (|BranchAddressGen_a| (|BranchAddressGenFormal_h BranchAddressGen| state))
))
(define-fun |BranchAddressGenFormal_u| ((state |BranchAddressGenFormal_s|)) Bool 
  (|BranchAddressGen_u| (|BranchAddressGenFormal_h BranchAddressGen| state))
)
(define-fun |BranchAddressGenFormal_i| ((state |BranchAddressGenFormal_s|)) Bool 
  (|BranchAddressGen_i| (|BranchAddressGenFormal_h BranchAddressGen| state))
)
(define-fun |BranchAddressGenFormal_h| ((state |BranchAddressGenFormal_s|)) Bool (and
  (= (|BranchAddressGenFormal_is| state) (|BranchAddressGen_is| (|BranchAddressGenFormal_h BranchAddressGen| state)))
  (= (|BranchAddressGenFormal#0| state) (|BranchAddressGen_n sourceReg1| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.sourceReg1
  (= (|BranchAddressGenFormal#1| state) (|BranchAddressGen_n programCounter| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.programCounter
  (= (|BranchAddressGenFormal#2| state) (|BranchAddressGen_n jalr| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.jalr
  (= (|BranchAddressGenFormal#3| state) (|BranchAddressGen_n jal| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.jal
  (= (|BranchAddressGenFormal#5| state) (|BranchAddressGen_n jTypeImmd| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.jTypeImmd
  (= (|BranchAddressGenFormal#6| state) (|BranchAddressGen_n iTypeImmd| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.iTypeImmd
  (= (|BranchAddressGenFormal#4| state) (|BranchAddressGen_n branch| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.branch
  (= (|BranchAddressGenFormal#7| state) (|BranchAddressGen_n bTypeImmd| (|BranchAddressGenFormal_h BranchAddressGen| state))) ; BranchAddressGen.bTypeImmd
  (|BranchAddressGen_h| (|BranchAddressGenFormal_h BranchAddressGen| state))
))
(define-fun |BranchAddressGenFormal_t| ((state |BranchAddressGenFormal_s|) (next_state |BranchAddressGenFormal_s|)) Bool 
  (|BranchAddressGen_t| (|BranchAddressGenFormal_h BranchAddressGen| state) (|BranchAddressGenFormal_h BranchAddressGen| next_state))
) ; end of module BranchAddressGenFormal
; yosys-smt2-topmod BranchAddressGenFormal
; end of yosys output
