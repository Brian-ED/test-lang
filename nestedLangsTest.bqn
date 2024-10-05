#! ./lang2.bqn

# This "lang2" can be applied recursively
test ← {#! ./lang2.bqn
  •Show 1+1
  
  •Out ∾⟜(@+10)⁼{#! /usr/bin/env bqn -e
    •Out "hiii"
  }

  # python inside lang2 :D
  •Out {#! /usr/bin/env python3 -c
print("hiii2",end="") # indentation errors in python :(
  }
}
•Out ∾⟜(@+10)⁼test