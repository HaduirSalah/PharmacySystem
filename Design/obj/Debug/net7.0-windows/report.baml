   M S B A M L   `   `   `  ����A  =Design, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullclr-namespace:DesignDesign  5   	       Design.report   5      W SPresentationCore, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   &localclr-namespace:Design     5   	   $	��650��5      $	��900��6   
�������  � 	Resources  5       �� 
TargetType �� Property �� Value   DEfaultButtonStyle=  7System.Windows.Controls.Primitives.DataGridColumnHeader��%m  '��       &	  �     '  �    �� 5   
   " ��6   �5      �� 5       � ��$ 15(�6-   6:   �� 5       � �� �#628cc36A   5      �� 5   
   �5      �� 5       � ��$ 20(�65   6B   �� 5       � ��
 �����6K   �� 5       � ��
 ��d�6P   �� 5       � ��$
 15 5q�6<   6K   �� 5       � ��$ 5q�64   6@   �� 5       � ��$	 100��6;   6I   5      �� 5!   
   "  6   .�5"      ��  � ��
 ��d�6+   �� 5#       � ��
 �����6+   �� 5$       � ��$ 15(�6)   �� 5%       � ��$ 30��6'   5&      5)      .��5*      �  � ColumnDefinitions 5,   
   �� 5-      $	��750 �6   �� 5.      $��0 �6   .+�51   
   �� $��	0,0,0,324q�6   $��0��6(   .+�52      �� 
����d�$��10,18,-10,375q�60   $��Center=�6G   $��20(�6l   $
��Bold"�6z   $	��338��6�   .��6�   Show the Company Report6�   �� 53      -   5         ��Name$ 
CompNametb��53   0   $	��169��6   $��24��6$   
�������$��Center=�6Y   $��0,-504,0,205q�6v   6�   55      �� 56   
   $��10,92,0,-216q�6   .+�57      &   System.Windows.Controls.DataGrid  -   5          Name$ MidGrid��57      $	��519��6(   $	��440��64      
IsReadOnly$
 True��6B   $��	-4,24,0,0q�6T      Columns 58      0  *System.Windows.Controls.DataGridTextColumn  59      ,  &System.Windows.Controls.DataGridColumn	   Header$	 Name-Medician��6)   
   Width5  /System.Windows.Controls.DataGridLengthConverter$	
 120 6]   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6B   �� *Name+6]     5:      $	 Price��6)   $
 50 6Z    6:   �� *	UnitPrice+6Z     5;      $	 Quantity��6)   $
 80 6\    6=   �� *
quantity+6\     5<      $	 PDate��6)   $
 60 6_    6:   �� *ProductionDate+6_     5=      $	 ExpDate��6)   $
 60 6Z    6<   �� *	ExpDate+6Z     5>      $	 EnteredDate��6)    6@   �� *EnteredDate+5@      5C      5H      5K      