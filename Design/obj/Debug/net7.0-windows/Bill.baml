   M S B A M L   `   `   `  ����A  =Design, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:DesignDesign  5   	       Design.MainWindow   5      W SPresentationCore, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:Design     5   	   $	��650��5      $	��900��6   
�������.��5      � 4  .System.Windows.Automation.AutomationProperties    Name$  Billing Form��6   $��1��64    � ColumnDefinitions 5   
   �� 5      $
��825* �6   �� 5      $��* �6   .+�5   
   � -   5         �Name$ BillingForm��5      $��60��6$   $	��Top=�62   $��2��6J   .+�5      �� $��40(�6   $
��Left=�6&   $��16,0,0,0q�6A   
����d�BillingForm :6~   5      � 5   
   $��2��6    5      �� 5      $��* �6#   6/   �� 5      $
��1.4* �6#   62    � RowDefinitions 5      �� 5      6"   .+�5      �� -   5        $
��Left=�5      $��5,94,0,0q�64   $	��294��6a   .+�5      �� -   5         ��Name$ SelectMedicines��5      $��18(�64   $��30��6B   $	��234��6N   $��2,0,35,0q�6Z   6l   �� 5      -   5         ��Name$ AvailableMedicines��5      $��20(�68   $��Medium"�6F   $��Center=�6Z   $��	0,45,34,0q�6w   
����d��� 6�   $�AvailableMedicinesInStock��6�   6�   � 5       $��
-10,50,0,0q�6   .+�5!      �� $��20(�6!   $��Medium"�6/   $��	19,-2,4,0q�6C   
����d��� 6s   $�
Quantity :��6w   6�   �� 5"      -   5         ��Name$ QuantityTextbox��5"      $��20(�67   $��30��6F   $	��120��6R   $��127,-29,1,2q�6^   5#      �� 5$      -   5        $	��166��5$      $��40��6%   
����d�$��20(�6M   $��Medium"�6[   
�������$��0,83,0,0q�6�   $��Add To Bill��5%   A   5&      �� 5'      -   5        $	��166��5'      $��40��6%   
����d�$��20(�6M   $��Medium"�6[   
�������$��0,-257,-2,-334q�6�   $��Print��5(   ;   5)      �� 5*      $��Bill.png��6   $��60��6*   $��30��65   $��0,-260,81,-334q�6A   6[   5+      � 5,      -   5        $��	PrintGrid��5,      $��10,0,0,0q�6$   $��1��66   .+�5-      &   System.Windows.Controls.DataGrid  -	   5          Name$ DataGridBill��5-   Q   $��15(�6   
���   �$��Medium"�6<   $��-59,10,0,251q�6g    � 	Resources 5.      =  7System.Windows.Controls.Primitives.DataGridColumnHeader	 �� 
TargetType
 �� Property �� Value��%�   '        �� 5/      "	  6    .�50      �� 
 � ��
 ��d�6;   �� 51      
 � ��$ 0 0 12 0q�67   6J   �� 52      
 � ��$ 0,0,1,2q�6@   6R   �� 53      
 � ��
 �����6Q   54      55         Columns 56      0  *System.Windows.Controls.DataGridTextColumn  58      -
   5        ID��,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$ 80 58   9      Header$ MedID��6D   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6S   �� *MedId+6o     59      $ MedName��6-   $	 100 6>    6J   �� *MedicineName+6m     5:      $ quantity��6-   $ 80 6?    6J   �� *
Quantity+6j     5;      $ 	UnitPrice��6-   $ 80 6@    6K   �� *	UnitPrice+6k     5<      $ 
TotalPrice��6-   $ 80 6A    6L   �� *
TotalPrice+6m     5=      $ EmpName��6-   $ 80 6>    6I   �� *EmployeeName+6l     5>      $
 Date��6-   $ 80 6;    6F   �� *Date+6a   5@      � 5B      $��Center=�6   $��
0,0,0,-350q�67   .+�5C      �� -   5         ��Name$ BillID��5C   *   $��20(�6   $��Bottom=�6:   $��
20,0,200,0q�6U   
����d�.��6�   
BillID :6�   �� 5D      -   5        $ 
TotalPrice��5D   *   $��20(�6   
����d�.��6[   Total Price :6j   5E      � 5F      $��10,0,0,-436q�6   $��Center=�61   .+�5G      �� -   5        $ BillId��5G   *   $��20(�6   $��Bottom=�6:   $��
20,0,200,0q�6U   6l   �� 5H      -   5        $ 
Totalprice��5H   *   $��20(�6   6A   5I      5K      5L      5M      5N      