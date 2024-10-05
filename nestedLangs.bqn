#! /usr/bin/env bqn

# use output files for print debugging, since lang2 uses stdout a lot:
# "out.txt"⊸•FChars∘•Repr⊸⊢

lf←@+10


EvalAsFile ← {
  err‿out‿errMsg ← •SH 𝕩∾⟜<˜' '((+`∘<⟜»⊸×-¬)∘≠⊔⊢)"#!"∾⁼𝕩↑˜𝕩⊐lf
  errMsg!0=err
  out
}
EvalBox ← (•ReBQN {repl⇐"strict"}){𝕨𝔽'@'‿lf∾𝕩}
evalBoxes ← ⟨
  •path‿•name‿⟨⟩⊸EvalBox
  •path‿•name⊸∾∘<∘EvalAsFile⊸EvalBox⟜(∾⟜"•args")
⟩

Run ← {
  ⊢´{
    EvalBox 𝕨↓˜l←-lf⊐˜⌽𝕨
    <𝕩 (×≠𝕩)◶evalBoxes l↑𝕨
  }´˘↑‿2⥊ 𝕩⊔˜ (+`×¬)⊸- »⊸≠ ×+`-˝"{}"=⌜𝕩
}

⟨pathOrCode⟩←•args

Run •FChars⍟("#!"≢2⊸↑) pathOrCode
