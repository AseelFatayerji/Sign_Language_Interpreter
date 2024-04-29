from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.gridlayout import GridLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.image import Image

import kivysome
kivysome.enable( "https://kit.fontawesome.com/3466402afb.js", group=kivysome.FontGroup.REGULAR)

class MyApp(App):

    def build(self):
        self.image = Image()
        screen = GridLayout(rows=5)
        nav = BoxLayout()
        screen.add_widget(Button(text='Button 1'))      
        screen.add_widget(self.image)
        
        # nav.add_widget(Button(text=kivysome.icon('comment', 24)))  
        nav.add_widget(Button(text='Button 3'))
        nav.add_widget(Button(text='Button 4'))
        screen.add_widget(nav)
        return screen


if __name__ == '__main__':
    MyApp().run()