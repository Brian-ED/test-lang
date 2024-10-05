lf ← @+10

inbuiltTokens ← ⟨"⇐", "=", "⋄"⟩
map ← "a"‿'b' •Hashmap 1‿2

Tokenize ← {
  d←+`-⟜»˝"{}"=⌜𝕩
  parts ← 𝕩⊔˜+`0∾≠˝˘2↕d
  depthOfEachPart ← ⊑¨d⊔˜+`0∾≠˝˘2↕d

  split ← ∧`∘≠⟜'#'⊸/¨¨ lf((⊢-˜+`×¬)∘=⊔⊢)¨ parts
  blocks ← '{'=(⊑1↑⊑)¨split
  clean ← (¯1↓1↓⊢)¨⌾(blocks⊸/) split
  identifiers ← ' '((¬-˜⊢×·+`»⊸>)∘≠⊔⊢)¨¨clean
  tokens ← ⍷inbuiltTokens∾∾∾identifiers
  (∾(⊑∊⟜(↕≠inbuiltTokens))⊸∾¨)¨¨tokens⊸⊐¨¨identifiers
}
all ← •FChars "nestedLangsTest.bqn"

all Tokenize ↩

•Show all

# # SPACE
# 
# •Show »⊸∨ 0 {
#   𝕩? 1‿0≢𝕨
# ;
#   0‿0≡𝕨
# }˜`<˘⍉(@+10)‿' '=⌜0/n←"hello
#   dwad  
#   wa  dwa
#      dwa
#      awd
#  wada
# a"