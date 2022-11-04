import json
from pathlib import Path
import random
import sys

from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle 

def load_terms_from_json():
    with open('glossary.json', 'r', encoding='utf-8') as jsonfile:
        return json.load(jsonfile)

glossary_dict = load_terms_from_json()
glossary_list = random.sample(list(glossary_dict.items()), k=len(glossary_dict.keys()))

class GlossaryTermGenerator(QObject):
    def __init__(self):
        super().__init__()
        self.index = -1

    updateCard = Signal(str, str, arguments=['front', 'back'])

    @Slot()
    def incrementIndex(self):
        self.index = self.index + 1
        if(self.index > len(glossary_list)):
            self.index = 0
        front = glossary_list[self.index][1]
        back = glossary_list[self.index][0]
        self.updateCard.emit(front, back)

    @Slot()
    def decrementIndex(self):
        self.index = self.index - 1
        if(self.index < 0):
            self.index = len(glossary_list)
        front = glossary_list[self.index][1]
        back = glossary_list[self.index][0]
        self.updateCard.emit(front, back)

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    QQuickStyle.setStyle("Material")
    engine = QQmlApplicationEngine()

    glossary_term_generator = GlossaryTermGenerator()
    engine.rootContext().setContextProperty('termGenerator', glossary_term_generator)
    qml_file = Path(__file__).parent / 'view.qml'
    engine.load(qml_file)
    glossary_term_generator.incrementIndex()

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())