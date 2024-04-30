# from kivymd.app import MDApp
from kivy.app import App
from kivy.lang import Builder

from kivy.uix.screenmanager import ScreenManager, Screen
# import kivysome
# kivysome.enable( "https://kit.fontawesome.com/3466402afb.js", group=kivysome.FontGroup.REGULAR)
class MainWindow(Screen):
    pass

class SecondWindow(Screen):
    pass

class WindowManager(ScreenManager):
    pass

class SilentLearning(App):

    def build(self):
        
        return Builder.load_file('components/main.kv')


if __name__ == '__main__':
    SilentLearning().run()