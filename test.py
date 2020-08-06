import spacy
from benepar.spacy_plugin import BeneparComponent

nlp = spacy.load('en')
nlp.add_pipe(BeneparComponent("benepar_en2"))

doc = nlp(u"The time for action is now. It's never too late to do something.")
sent = list(doc.sents)[0]

print(sent._.parse_string)
print(list(sent._.children)[0])
