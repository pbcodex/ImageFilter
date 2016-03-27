#LIBRARY = 0

;//////////////////////////////////////////////////////////////////////////////
; Macro helper
;//////////////////////////////////////////////////////////////////////////////
Macro _QUOTE_
  "
EndMacro

Macro _
,
EndMacro

Macro void
EndMacro

Macro IMPORT_FUNCTION(LIB, NAME, RETURN_VALUE , PARAMETERS)
  PrototypeC#RETURN_VALUE NAME#(PARAMETERS)
  Global NAME.NAME = GetFunction(LIB,_QUOTE_#NAME#_QUOTE_)
EndMacro

Macro IMPORT_STATIC_FUNCTION(NAME, RETURN_VALUE , PARAMETERS)
  NAME#RETURN_VALUE#(PARAMETERS)
EndMacro

Select OSVersion()
    Case #PB_OS_Windows_XP, #PB_OS_Windows_7, #PB_OS_Windows_8, #PB_OS_Windows_10
      CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
        OpenLibrary(#LIBRARY,"ImageFilter_X86.dll")
      CompilerElse
        OpenLibrary(#LIBRARY,"ImageFilter_X64.dll")
      CompilerEndIf
      
      Case #PB_OS_Linux_2_2, #PB_OS_Linux_2_4, #PB_OS_Linux_2_6
        CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
          
        CompilerElse
          
        CompilerEndIf
EndSelect

; Creation d'une image brute selon une taille ( width & height ) 
; un tableau de pixel ou chaque composante a une valeur entre 0-255
; et son format d'image RGB / RGBA / BGR / BGRA
IMPORT_FUNCTION(#LIBRARY, CreateRawImage, .i , width.l _ height.l _ *pixels _ format.l)

; Clone une image brut, le resultat renvoyer est le clone
;
IMPORT_FUNCTION(#LIBRARY, CloneRawImage, .i , RawImage.l)

; Supprime une image brut
;
IMPORT_FUNCTION(#LIBRARY, FreeRawImage, void , RawImage.l )

; Renvois un pointeur vers le tableau de pixel de l'image brute
;
IMPORT_FUNCTION(#LIBRARY, GetRawImagePixelsPtr, .i , RawImage.l )

; Applique un filtre sur l'image brute, le filtre est cr�er via
; la fonction CreateFilter()

IMPORT_FUNCTION(#LIBRARY, ApplyFilter, void , RawImage.i _ RawFilter.i )

; Convertion d'une image brute en niveau de gris
;
IMPORT_FUNCTION(#LIBRARY, GrayScaleRawImage, void , RawImage.i )

; Change la luminosit� d'une image brute (-255 � 255)
;
IMPORT_FUNCTION(#LIBRARY, SetRawImageLuminosity, void , RawImage.i _ adjustement.i )

; Change le contraste d'une image brute (-255 � 255)
;
IMPORT_FUNCTION(#LIBRARY, SetRawImageContrast, void , RawImage.i _ adjustement.i )

; Change le gamma d'une image brut , id�alement le gamma peu prendre cette valeur ( 0.01 � 10.0 )
;
IMPORT_FUNCTION(#LIBRARY, SetRawImageGamma, void , RawImage.i _ gamma.f )

; Applique un seuil � l'image brute ( 0 - 255 )
; si la couleur du pixel est plus petit que threshold, le pixel est noir
; sinon, il est blanc.
IMPORT_FUNCTION(#LIBRARY, SetRawImageThreshold, void , RawImage.i _ threshold.a )

; Inverse une image brut ( n�gatif )
;
IMPORT_FUNCTION(#LIBRARY, InvertRawImage, void , RawImage.i )

; G�n�re une normalmap , chaque pixel repr�sente un vecteur en 3 dimension
; normalis� sous la forme (0 - 255)
;
IMPORT_FUNCTION(#LIBRARY, RawImageGenerateNormalMapping, void , RawImage.i _ factor.d )

; Cr�er un filtre de convolution � partir d'une taille ( width & height )
; et d'un tableau de double (*kernel) , ce tableau peut �tre un tableau � X dimension , une 
; datasection, un espace m�moire allou� via Allocatememory() , le principal etant 
; que les �l�ments soit contig�e & accessible
; le factor est g�n�ralement la somme des �l�ments du kernel normalis� � 1 ( 1 / sum(kernel) )
; le bias est g�n�ralement mis � 0 , tout d�pend du filtre.
; pour plus de filtre , il faut recherch� le terme "Filtre de convolution" ou "Convolution filter"
;
; https://en.wikipedia.org/wiki/Kernel_(image_processing)
;
; http://lodev.org/cgtutor/filtering.html
;
IMPORT_FUNCTION(#LIBRARY, CreateFilter, .i , width.l _ height.l _ factor.d _ bias.d _ *kernel )

; Supprime un filtre
;
IMPORT_FUNCTION(#LIBRARY, FreeFilter, void , RawFilter.i)


Enumeration
  #FORMAT_RGBA
  #FORMAT_RGB
  #FORMAT_BGRA
  #FORMAT_BGR
  #FORMAT_GRAY
EndEnumeration




; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 28
; FirstLine = 8
; Folding = --
; EnableUnicode
; EnableXP