library(shiny)
shinyUI(navbarPage("Capstone Project",
	tabPanel("Text Predictor",
		sidebarPanel(fluidRow = TRUE,
			p("Start by entering a word / some text / sentence", br(), "If nothing in mind,", br(), "start with \"", em("it"), "\", the most common word in english"), hr(),
			textInput("inp_txt", "Give the INPUT -", value = "it"),
			hr(),
			p("The Predicted Word / Words will appear in the main_panel.", br(),
				"Prediction is done on the basis of last 3 / 2 / 1 word/words entered.", br(),
				"A few words will be shown, all of which can be the next possible word."), hr()
		),
		mainPanel(
			h3("Data Science Specialization, Coursera, Capstone Project"),
			p("Here the input word / text / sentence will be displayed.", br(),
				"Along with the suggestion for the next word / words will be shown here"
			),
			hr(),
			p("Text Inputted so far :-"),
			textOutput("input"),
			hr(),
			p("Suggestions are as follows :-"),
			textOutput("suggestion"), 
			hr()
		)
	),
	tabPanel("Theory",
		mainPanel(
			p("The corpora are collected from publicly available sources by a web crawler.", br(),
				"The crawler checks for language, so as to mainly get texts consisting of the desired language", br(),
				"Each entry is tagged with it\'s date of publication. Where user comments are included they will be tagged with the date of the main entry.", br(),
				"Each entry is tagged with the type of entry, based on the type of website it is collected from (e.g. newspaper or personal blog).", br(),
				"If possible, each entry is tagged with one or more subjects based on the title or keywords of the entry", br(),
				"(e.g. if the entry comes from the sports section of a newspaper it will be tagged with \"sports\" subject).", br(),
				"In many cases it's not feasible to tag the entries", br(),
				"To save space, the subject and type is given as a numerical code.", br(),
				"Once the raw corpus has been collected, it is parsed further, to remove duplicate entries and split into individual lines.", br(),
				"Approximately 50% of each entry is then deleted. Since you cannot fully recreate any entries, the entries are anonymised,",br(),
				"and this is a non-profit venture I believe that it would fall under Fair Use."
			),
			hr(),
			h4("Libraries used for the task", br(),
				strong("NLP"), br(),
				strong("openNLP"), br(),
				strong("tm"), br(),
				strong("RWeka"), br(),
				strong("stringr"), br(),
				strong("stringi"), br(),
				strong("rJava"), br(),
				strong("dplyr"), br()
			)
		)
	),
	tabPanel("Few Tips",
		mainPanel(
			h3("Useful information for those with less RAM !"),
			strong("The Data is enormous, so I've taken a randomly chosen sample of 6000 sentences"),
			p("Initially, I started with creating the corpus, and then cleaning it off.", br(),
				"After this process, I started with the creation of the ", em("Uni-gram, Bi-gram, 3-Gram"), hr(),
				"The problem that I encountered was that I was unable to create all these at the same time one after the other", br(),
				pre("R does not seem to re-claim the memory that was previously used"), hr(),
				"So I came up with this little trick", br(),
				"I created the corpus from the given text, then I dumped it into a RData file", br(), "and ", em("restarted the R Session"), br(),
				"Now I created the Uni-gram, Bi-gram, 3-Gram, seperately,", br(), "by loading the corpus, and then dumped them back into RData files !",
				hr()
			)
		)
	),
	tabPanel("Important Links",
		mainPanel(
			h3(uiOutput("dss")),
			h4(uiOutput("datasrc")),
			h5(uiOutput("pro")), hr(),
			h4("Author", br(), strong("Chinmoy Das"), br(), "Date :- April 14, 2018"), hr(),
			img(src = 'swiftkey_logo.jpg', height = 101, width = 498), hr(),
			img(src = 'coursera_logo.png', height = 122, width = 467), hr()
		)
	)
))