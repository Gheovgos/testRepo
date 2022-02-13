package GUI;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JTextPane;

import controller.*;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.Color;
import java.awt.event.ItemListener;
import java.awt.event.ItemEvent;
import java.awt.Toolkit;
import java.awt.SystemColor;
import java.awt.Font;

public class VisualizzaTestDaCorreggere {

	JFrame frame;
	Controller controller;
	String username_s;
	String[] rm;
	String[] rs;
	

	public VisualizzaTestDaCorreggere(Controller c) {
		controller = c;
		initialize();
		frame.setVisible(true);
	}


	private void initialize() {
		
		rs = controller.returnTestName(controller.i.username, 0);
		controller.caricaTest(rs[0]);
		rm = controller.returnStudenti(controller.t.id);
		
		frame = new JFrame();
		frame.setTitle("Manabi");
		frame.setIconImage(Toolkit.getDefaultToolkit().getImage(VisualizzaTestDaCorreggere.class.getResource("/Immagini/icona manabi.png")));
		frame.getContentPane().setBackground(Color.WHITE);
		frame.setBounds(100, 100, 450, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		
		JComboBox comboStud = new JComboBox();
		JButton correggiButton = new JButton("CORREGGI");
		correggiButton.setForeground(SystemColor.textHighlight);
		JTextPane txtpnSelezionaIlTest = new JTextPane();
		txtpnSelezionaIlTest.setFont(new Font("Tahoma", Font.BOLD, 10));
		JTextPane txtpnNonPuoiCreare = new JTextPane();
		txtpnNonPuoiCreare.setForeground(SystemColor.textHighlight);
		txtpnNonPuoiCreare.setText("Non ci sono test da correggere.");
		txtpnNonPuoiCreare.setEditable(false);
		txtpnNonPuoiCreare.setVisible(false);
		txtpnNonPuoiCreare.setBounds(10, 30, 396, 23);
		frame.getContentPane().add(txtpnNonPuoiCreare);
		JComboBox comboTest = new JComboBox();
		
		if(rm[0] == null) {
			txtpnSelezionaIlTest.setVisible(false);
			txtpnNonPuoiCreare.setVisible(true);
			comboStud.setVisible(false);
			correggiButton.setVisible(false);
			comboTest.setVisible(false);
			rs = new String[1]; 
			rm = new String[1];
			rm[0] = "";
		}
		
		
		int max = rs.length;
		username_s = rm[0];
		
		
		
		
		comboTest.setMaximumRowCount(max);
		comboTest.setModel(new DefaultComboBoxModel(rs));
		comboTest.setSelectedIndex(0);
		comboTest.setBounds(10, 61, 207, 22);
		frame.getContentPane().add(comboTest);
		
		
		txtpnSelezionaIlTest.setEditable(false);
		txtpnSelezionaIlTest.setText("SELEZIONA TEST DA CORREGGERE:");
		txtpnSelezionaIlTest.setBounds(10, 11, 238, 20);
		frame.getContentPane().add(txtpnSelezionaIlTest);
		
		
		JButton back = new JButton("INDIETRO");
		back.setForeground(SystemColor.textHighlight);
		back.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				frame.setVisible(false);
			}
		});
		back.setBounds(10, 227, 89, 23);
		frame.getContentPane().add(back);
		
		
		correggiButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				int selected = 0;
				selected = comboTest.getSelectedIndex();
				controller.caricaTest(rs[selected], controller.i.username);
				controller.caricaStudente(username_s);
				CorreggiTest next = new CorreggiTest(controller);
				frame.setVisible(false);
				
			}
		});
		correggiButton.setBounds(335, 227, 89, 23);
		frame.getContentPane().add(correggiButton);
		
		
		
		comboStud.setModel(new DefaultComboBoxModel(rm));
		comboStud.setBounds(227, 61, 197, 22);
		frame.getContentPane().add(comboStud);
		
		comboTest.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				int selected = 0;
				selected = comboTest.getSelectedIndex();
				controller.caricaTest(rs[selected]);
				rm = controller.returnStudenti(controller.t.id);
			}
		});
		
		comboStud.addItemListener(new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				int selected = 0;
				selected = comboStud.getSelectedIndex();
				username_s = rm[selected];	
			}
		});
	}
}
