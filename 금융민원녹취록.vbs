Set sh = CreateObject("WScript.Shell")
sh.CurrentDirectory = "C:\Users\Training-17\Desktop\vive\stt_transcriber"
sh.Run chr(34) & "C:\Users\Training-17\Desktop\vive\stt_transcriber\.venv\Scripts\pythonw.exe" & chr(34) & " " & chr(34) & "C:\Users\Training-17\Desktop\vive\stt_transcriber\tools\run_g1_launcher.py" & chr(34), 0, False