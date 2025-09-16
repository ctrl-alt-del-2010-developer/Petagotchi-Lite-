import os
import time
import random
import sys
import threading

ayar = 1  # 1 = pwngotchi, 0 = menu

emote1 = """
               ( UwU)
     
  if I am grow up, I can pwn myself 
"""
emote2 = """
               ( T_T)

  Really, This Hardware? I can't pwn
"""
emote3 = """
               (+__+)    

       Yeah, so many pwngotchis!
"""
emote4 = """
               (^__^)
 
          I love pwngotchis!
"""
emote5 = """
               (-__-)

  Seriously, it is great time a walk.   
"""
emote6 = """
               (*__*)

            3.14159265359 
"""
emote7 = """
               ( O__O)

           Wanted: Friends
"""
emote8 = """
               (⌐■_■)
        
        Agent Mode Activated!     
"""

emotelist = [emote1, emote2, emote3, emote4, emote5, emote6, emote7, emote8]

# Menüye geçiş flag’i
menu_flag = False

# Space veya Enter tuşunu bekleyen thread
def input_thread():
    global ayar, menu_flag
    while True:
        user_input = input()
        if user_input == "" or user_input == " ":
            menu_flag = True
            ayar = 0
            break

# Başlangıçta input thread çalışıyor
threading.Thread(target=input_thread, daemon=True).start()

while True:
    if ayar == 1:
        os.system("clear")
        current_face = random.choice(emotelist)
        print("  -----------------------------------")
        print(current_face)
        print("  -----------------------------------")
        # Kısa bekleme, yüz değişimi animasyonu gibi
        for _ in range(5):
            time.sleep(0.5)
            if menu_flag:
                break
    else:
        os.system("clear")
        print("  |-------------»Menu«---------------|")
        print("  [01] Find Friends")
        print("  [02] Exit")
        secim = input("  > ")
        if secim == "1":
            ayar = 1
            menu_flag = False
            threading.Thread(target=input_thread, daemon=True).start()  # Yeni input thread
        elif secim == "2":
            print("\nÇıkış yapılıyor...")
            break
        else:
            print("\nGeçersiz seçenek! Tekrar deneyin.")
            time.sleep(1)
