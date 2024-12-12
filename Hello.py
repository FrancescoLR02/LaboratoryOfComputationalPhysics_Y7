def Hello(func):
   def Ciao():
      print("Ciao")
      func()

   return Ciao
