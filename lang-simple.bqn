
#####################
# Constants #
nl←10+@
varChars ← ⥊"aA"+⌜↕26

Debug ← ⊢ #•Out
AddToken ← {𝕨𝕊rules: char←𝕨⊣""
  tokens∾↩<char∾˜recentToken
  recentToken↩""
  rulesAtTokens∾↩<𝕩
  Debug "Token done"
}
AddPastToken ← {rules𝕊char:
  tokens∾↩<recentToken
  recentToken↩⟨𝕩⟩
  rulesAtTokens∾↩<𝕨
  Debug "Token done"
}
ClearToken ← {𝕊@:
  recentToken↩""
}
NewToken ← {𝕊char:
  recentToken↩⟨𝕩⟩
}
#####################

#####################
# Mutable variables #
tokens ← ⟨⟩ # tokens ← each character in string doesn't change the rules `all≡∾´tokens`
rulesAtTokens ← ⟨⟩ # each token has rules that apply to all chars in it
recentToken ← ""
#####################

#├┤┴┬─│┌┐└┘┼
last ← {
# ┌isText
# │ ┌isComment
# │ │ ┌isVar
# │ │ │
# │ │ │ ┌Nesting depth
 𝕊0‿0‿0‿0:
  0‿0‿0‿0
;𝕊0‿1‿0‿0: 𝕨AddPastToken𝕩 ⋄ Debug "Comment ended"
  0‿0‿0‿0
;𝕊1‿0‿0‿0: !"String ended at end-of-file"
;𝕊0‿0‿1‿0: !"Var ended at end-of-file"
;𝕊0‿0‿0‿n: 0≠n? !"Ended at non-zero nesting"
} 0‿0‿0‿0 { # default
  0‿0‿0‿n𝕊'"': ClearToken@ ⋄ Debug "str begin"
  1‿0‿0‿n
; 1‿0‿0‿n𝕊'"': AddToken𝕨 ⋄ Debug "str end"
  0‿0‿0‿n
; 0‿0‿0‿n𝕊'#': ClearToken@ ⋄ Debug "Comment begin"
  0‿1‿0‿n
; 0‿1‿0‿n𝕊'⋄': 𝕨AddPastToken𝕩 ⋄ Debug "Comment end"
  0‿0‿0‿n
; 0‿0‿0‿n𝕊'[': ClearToken@ ⋄ c←n+1 ⋄ Debug "Bracket begin"
  0‿0‿0‿c
; 0‿0‿0‿c𝕊']': "Too many ending brackets"!0<c ⋄ n←c-1 ⋄ Debug "Bracket end"
  0‿0‿0‿n AddToken⊸⊢∘⊣@
; 0‿0‿0‿n𝕊𝕩: ⊑𝕩∊varChars? NewToken𝕩 ⋄ Debug "Var begin"
  0‿0‿1‿n
; 0‿0‿1‿n𝕊𝕩: ¬⊑𝕩∊varChars? 𝕩AddToken𝕨 ⋄ Debug "Var end"
  0‿0‿0‿n
; recentToken∾↩𝕩 ⋄ 𝕨
}˜´⌽ {'⋄'¨⌾((nl=𝕩)⊸/)𝕩} "ab_ ← ""cd "" ef_
  # hello ""
  [ ""hii"" ]
  [""boo""]
  [""hi""[[ ""hii"" ]""aa""]]
"

# •Out "[["
# •Out¨"  "⊸∾¨(•Repr¨rulesAtTokens)∾˜¨(' '⥊˜¨5+≠¨-˜·⌈´≠¨)⊸(∾¨˜)tokens
# •Out "]]"

# [[
#   ab_          0‿0‿1‿0
#   cd           1‿0‿0‿0
#   ef_          0‿0‿1‿0
#    hello "     0‿1‿0‿0
#   hii          1‿0‿0‿1
#                0‿0‿0‿0
#   boo          1‿0‿0‿1
#                0‿0‿0‿0
#   hi           1‿0‿0‿1
#   hii          1‿0‿0‿3
#                0‿0‿0‿2
#   aa           1‿0‿0‿2
#                0‿0‿0‿1
#                0‿0‿0‿0
# ]]

str ← 0⊑¨rulesAtTokens
comment ← 1⊑¨rulesAtTokens
var ← 2⊑¨rulesAtTokens
nesting ← 3⊑¨rulesAtTokens
brackets ← »⊸>nesting
literals ← ∨´⟨str⋄var⋄brackets⟩
2
•Show literals/nesting
•Show (literals/nesting)⊔˜+`literals/brackets
•Show ⟨⟩¨/brackets