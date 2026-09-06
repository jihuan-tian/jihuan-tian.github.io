---
layout: post
title: Manage scanned notes and sketches with LibreOffice Impress
date: 2025-03-19
categories: [computer]
tags: [libreoffice,Bash,note-taking]
mathjax: false
---

Just realized I can use LibreOffice Impress to collect my scattered scanned images for mathematical derivations on paper work journal and notebook as well as white board. Compared to LibreOffice Draw, the pages in Impress can be easily shifted and reorganized.

-   A VBA script has been written for inserting, positioning and resizing the images automatically in LibreOffice Impress.

    
    ```
    ' Select image files and append one linked image per new slide.
    ' Re-run anytime to add more images.
    '
    ' Do NOT use .uno:InsertGraphic here: after the first image it often reopens
    ' the file dialog. Insert each GraphicObjectShape onto its page via the API
    ' with LoadAsLink instead. LibreOffice rewrites links to relative paths on
    ' save when "Save URLs relative to file system" is enabled.
    Sub InsertLinkedImagesFromSelection()
        Dim oDoc As Object
        Dim files As Object
        Dim oPages As Object
        Dim oPage As Object
        Dim oGraph As Object
        Dim oProvider As Object
        Dim oProps(1) As New com.sun.star.beans.PropertyValue
        Dim oInputFile As Object
        Dim oInputStream As Object
        Dim sFileURL As String
        Dim sFileContent As String
        Dim aSizeParts() As String
        Dim dpi As Integer
        Dim oBitmapSize As New com.sun.star.awt.Size
        Dim oNewSize As New com.sun.star.awt.Size
        Dim oPosition As New com.sun.star.awt.Point
        Dim dImageRatio As Double
        Dim dPageRatio As Double
        Dim i As Integer

        oDoc = ThisComponent
        files = SelectMultipleImages()
        If IsNull(files) Then Exit Sub
        If UBound(files) < LBound(files) Then Exit Sub

        If oDoc.URL = "" Then
            MsgBox "Please save the Impress document first so image links can be stored relative to the .odp file."
            Exit Sub
        End If

        oProvider = CreateUnoService("com.sun.star.graphic.GraphicProvider")
        oPages = oDoc.getDrawPages()
        dpi = 168

        For i = LBound(files) To UBound(files)
            sFileURL = files(i)
            If Not IsImageURL(sFileURL) Then GoTo ContinueLoop

            CallBashScript("/usr/local/bin/scripts/call_get_img_size.sh", ConvertFromURL(sFileURL))
            oInputFile = CreateUnoService("com.sun.star.ucb.SimpleFileAccess")
            oInputStream = oInputFile.openFileRead("/tmp/img-size.txt")
            sFileContent = ReadInputStream(oInputStream)
            oInputStream.closeInput()
            aSizeParts = Split(sFileContent, "x")

            oPage = oPages.insertNewByIndex(oPages.getCount())
            oPage.setName(ConvertFromURL(sFileURL))
            ' Blank layout avoids title/body placeholders
            oPage.Layout = 20

            ' Scale to fit the page. LibreOffice size unit is 1/100 mm.
            oBitmapSize.Width = Val(Trim(aSizeParts(0))) / dpi * 25.4 * 100
            oBitmapSize.Height = Val(Trim(aSizeParts(1))) / dpi * 25.4 * 100
            dImageRatio = CDbl(oBitmapSize.Height) / CDbl(oBitmapSize.Width)
            dPageRatio = CDbl(oPage.Height) / CDbl(oPage.Width)

            If oBitmapSize.Width > oPage.Width Or oBitmapSize.Height > oPage.Height Then
                If dPageRatio > dImageRatio Then
                    oNewSize.Width = oPage.Width
                    oNewSize.Height = CLng(CDbl(oPage.Width) * dImageRatio)
                Else
                    oNewSize.Width = CLng(CDbl(oPage.Height) / dImageRatio)
                    oNewSize.Height = oPage.Height
                End If
            Else
                oNewSize.Width = oBitmapSize.Width
                oNewSize.Height = oBitmapSize.Height
            End If

            oPosition.X = (oPage.Width - oNewSize.Width) / 2
            oPosition.Y = (oPage.Height - oNewSize.Height) / 2

            oGraph = oDoc.createInstance("com.sun.star.drawing.GraphicObjectShape")
            oGraph.SetSize(oNewSize)
            oGraph.SetPosition(oPosition)

            ' Absolute file URL + LoadAsLink. Do not set GraphicURL to a relative
            ' path before add() — that raises IllegalArgumentException.
            oProps(0).Name = "URL"
            oProps(0).Value = sFileURL
            oProps(1).Name = "LoadAsLink"
            oProps(1).Value = True
            oGraph.Graphic = oProvider.queryGraphic(oProps())

            oPage.add(oGraph)

ContinueLoop:
        Next i
    End Sub

    ' Same flow as InsertLinkedImagesFromSelection, but embeds each image into
    ' the .odp (copies the bitmap in). The document is self-contained; external
    ' files are no longer needed after insert. Save-before-run is not required.
    Sub InsertEmbeddedImagesFromSelection()
        Dim oDoc As Object
        Dim files As Object
        Dim oPages As Object
        Dim oPage As Object
        Dim oGraph As Object
        Dim oProvider As Object
        Dim oProps(0) As New com.sun.star.beans.PropertyValue
        Dim oInputFile As Object
        Dim oInputStream As Object
        Dim sFileURL As String
        Dim sFileContent As String
        Dim aSizeParts() As String
        Dim dpi As Integer
        Dim oBitmapSize As New com.sun.star.awt.Size
        Dim oNewSize As New com.sun.star.awt.Size
        Dim oPosition As New com.sun.star.awt.Point
        Dim dImageRatio As Double
        Dim dPageRatio As Double
        Dim i As Integer

        oDoc = ThisComponent
        files = SelectMultipleImages()
        If IsNull(files) Then Exit Sub
        If UBound(files) < LBound(files) Then Exit Sub

        oProvider = CreateUnoService("com.sun.star.graphic.GraphicProvider")
        oPages = oDoc.getDrawPages()
        dpi = 168

        For i = LBound(files) To UBound(files)
            sFileURL = files(i)
            If Not IsImageURL(sFileURL) Then GoTo ContinueEmbedLoop

            CallBashScript("/usr/local/bin/scripts/call_get_img_size.sh", ConvertFromURL(sFileURL))
            oInputFile = CreateUnoService("com.sun.star.ucb.SimpleFileAccess")
            oInputStream = oInputFile.openFileRead("/tmp/img-size.txt")
            sFileContent = ReadInputStream(oInputStream)
            oInputStream.closeInput()
            aSizeParts = Split(sFileContent, "x")

            oPage = oPages.insertNewByIndex(oPages.getCount())
            oPage.setName(ConvertFromURL(sFileURL))
            oPage.Layout = 20

            oBitmapSize.Width = Val(Trim(aSizeParts(0))) / dpi * 25.4 * 100
            oBitmapSize.Height = Val(Trim(aSizeParts(1))) / dpi * 25.4 * 100
            dImageRatio = CDbl(oBitmapSize.Height) / CDbl(oBitmapSize.Width)
            dPageRatio = CDbl(oPage.Height) / CDbl(oPage.Width)

            If oBitmapSize.Width > oPage.Width Or oBitmapSize.Height > oPage.Height Then
                If dPageRatio > dImageRatio Then
                    oNewSize.Width = oPage.Width
                    oNewSize.Height = CLng(CDbl(oPage.Width) * dImageRatio)
                Else
                    oNewSize.Width = CLng(CDbl(oPage.Height) / dImageRatio)
                    oNewSize.Height = oPage.Height
                End If
            Else
                oNewSize.Width = oBitmapSize.Width
                oNewSize.Height = oBitmapSize.Height
            End If

            oPosition.X = (oPage.Width - oNewSize.Width) / 2
            oPosition.Y = (oPage.Height - oNewSize.Height) / 2

            oGraph = oDoc.createInstance("com.sun.star.drawing.GraphicObjectShape")
            oGraph.SetSize(oNewSize)
            oGraph.SetPosition(oPosition)

            ' URL only — no LoadAsLink, so the bitmap is embedded in the document
            oProps(0).Name = "URL"
            oProps(0).Value = sFileURL
            oGraph.Graphic = oProvider.queryGraphic(oProps())

            oPage.add(oGraph)

ContinueEmbedLoop:
        Next i
    End Sub

    ' Multi-select does not preserve click order on many systems (e.g. GTK).
    ' Sort with version-number order so page2 comes before page10.
    Function SelectMultipleImages() As Object
        Dim oFilePicker As Object
        Dim files As Object
        oFilePicker = CreateUnoService("com.sun.star.ui.dialogs.FilePicker")
        oFilePicker.setMultiSelectionMode(True)
        oFilePicker.setTitle("Select Images")
        oFilePicker.appendFilter("Images (*.png;*.jpg;*.jpeg)", "*.png;*.jpg;*.jpeg")
        oFilePicker.appendFilter("All files (*.*)", "*.*")
        oFilePicker.setCurrentFilter("Images (*.png;*.jpg;*.jpeg)")
        If oFilePicker.execute() <> 1 Then
            SelectMultipleImages = Array()
            Exit Function
        End If
        files = oFilePicker.getSelectedFiles()
        SelectMultipleImages = SortFileURLsByVersion(files)
    End Function

    Function SortFileURLsByVersion(files As Object) As Object
        Dim a() As String
        Dim i As Integer
        Dim j As Integer
        Dim sTmp As String
        Dim nLow As Integer
        Dim nHigh As Integer

        If IsNull(files) Then
            SortFileURLsByVersion = Array()
            Exit Function
        End If
        nLow = LBound(files)
        nHigh = UBound(files)
        If nHigh < nLow Then
            SortFileURLsByVersion = Array()
            Exit Function
        End If

        ReDim a(nLow To nHigh)
        For i = nLow To nHigh
            a(i) = files(i)
        Next i

        For i = nLow To nHigh - 1
            For j = i + 1 To nHigh
                If VersionComparePath(ConvertFromURL(a(j)), ConvertFromURL(a(i))) < 0 Then
                    sTmp = a(i)
                    a(i) = a(j)
                    a(j) = sTmp
                End If
            Next j
        Next i

        SortFileURLsByVersion = a
    End Function

    ' Version/natural compare, similar to sort -V: digit runs compared as numbers.
    ' Returns -1 if s1 < s2, 0 if equal, 1 if s1 > s2.
    Function VersionComparePath(s1 As String, s2 As String) As Integer
        Dim i1 As Integer
        Dim i2 As Integer
        Dim len1 As Integer
        Dim len2 As Integer
        Dim c1 As String
        Dim c2 As String
        Dim n1 As Double
        Dim n2 As Double

        i1 = 1
        i2 = 1
        len1 = Len(s1)
        len2 = Len(s2)

        Do While i1 <= len1 And i2 <= len2
            c1 = Mid(s1, i1, 1)
            c2 = Mid(s2, i2, 1)

            If (c1 >= "0" And c1 <= "9") And (c2 >= "0" And c2 <= "9") Then
                n1 = 0
                Do While i1 <= len1
                    c1 = Mid(s1, i1, 1)
                    If c1 < "0" Or c1 > "9" Then Exit Do
                    n1 = n1 * 10 + Val(c1)
                    i1 = i1 + 1
                Loop
                n2 = 0
                Do While i2 <= len2
                    c2 = Mid(s2, i2, 1)
                    If c2 < "0" Or c2 > "9" Then Exit Do
                    n2 = n2 * 10 + Val(c2)
                    i2 = i2 + 1
                Loop
                If n1 < n2 Then
                    VersionComparePath = -1
                    Exit Function
                End If
                If n1 > n2 Then
                    VersionComparePath = 1
                    Exit Function
                End If
            Else
                If c1 < c2 Then
                    VersionComparePath = -1
                    Exit Function
                End If
                If c1 > c2 Then
                    VersionComparePath = 1
                    Exit Function
                End If
                i1 = i1 + 1
                i2 = i2 + 1
            End If
        Loop

        If len1 < len2 Then
            VersionComparePath = -1
        ElseIf len1 > len2 Then
            VersionComparePath = 1
        Else
            VersionComparePath = 0
        End If
    End Function

    Function IsImageURL(sURL As String) As Boolean
        Dim s As String
        s = LCase(sURL)
        IsImageURL = (InStr(s, ".png") > 0 Or InStr(s, ".jpg") > 0 Or InStr(s, ".jpeg") > 0)
    End Function

    ' LibreOffice Basic can only start an asynchronous process, so wait for the
    ' script to finish. Arguments do not need to be escaped.
    Sub CallBashScript(sScriptPath As String, sArgs As String)
        Dim oShell As Object
        oShell = CreateUnoService("com.sun.star.system.SystemShellExecute")
        oShell.execute(sScriptPath, sArgs, 0)
        Wait 1000
    End Sub

    Function ReadInputStream(oInputStream As Object) As String
        Dim oTextStream As Object
        oTextStream = CreateUnoService("com.sun.star.io.TextInputStream")
        oTextStream.setInputStream(oInputStream)
        oTextStream.setEncoding("UTF-8")
        ReadInputStream = oTextStream.readLine()
    End Function
    ```
    
    The Bash script `call_get_img_size.sh` is as below. It calls `identify` to get the image information, from which we write the image size into a temporary file.
    
    ```bash
    echo $(identify "$1" | gawk '{if(match($0, /([[:digit:]]+)x([[:digit:]]+)/, res) != 0) print res[0];}') > /tmp/img-size.txt
    ```

-   For eye-protection, the white background of each image is converted to light yellow, i.e. RGB 246, 240, 222, with the command line image editing tool ImageMagick.
    
    ```bash
    #!/bin/bash
    mogrify -fuzz 10% -fill 'rgb(246,240,222)' -opaque white "$file"
    ```
-   The handwriting in each inserted image can be further edited with Wacom+Krita.
-   The whole Impress document or its internal bookmarks can be further linked into Org mode, so that they can be categorized and tagged in the [Zettelkasten]({% post_url 2024-10-01-基于卡片笔记写作法的个人笔记改进 %}) note system.

{{ "2025-03-18-manage-scanned-notes-and-sketches-with-libreoffice-impress" | backlink }}
