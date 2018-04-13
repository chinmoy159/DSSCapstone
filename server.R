library(shiny);
library(NLP);
library(tm);
library(RWeka);
library(openNLP);

shinyServer(function(input, output) {
	url_for_data <- a("Coursera-Swiftkey Dataset", href = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip");
	output$datasrc <- renderUI({
		tagList(url_for_data);
	})
	dss <- a("Data Science Specialization, JHU, Coursera", href = "https://www.coursera.org/specializations/jhu-data-science");
	output$dss <- renderUI({
		tagList(dss);
	})
	prof <- a("Offensive / Profane Words List", href = "https://www.cs.cmu.edu/~biglou/resources/");
	output$pro <- renderUI({
		tagList(prof);
	})
	output$input <- renderText ({
		return(input$inp_txt);
	})

	bigram <- readRDS("bigram.RData");
	bigram$word1 <- as.character (bigram$word1); bigram$word2 <- as.character (bigram$word2);

	trigram <- readRDS("trigram.RData");
	trigram$word1 <- as.character (trigram$word1); trigram$word2 <- as.character (trigram$word2); trigram$word3 <- as.character (trigram$word3);

	quadgram <- readRDS("quadgram.RData");
	quadgram$word1 <- as.character (quadgram$word1); quadgram$word2 <- as.character (quadgram$word2);
	quadgram$word3 <- as.character (quadgram$word3); quadgram$word4 <- as.character (quadgram$word4);

	bigram_func <- function (given_txt) {
		# print("part_1")
		res = bigram[bigram$word1 == given_txt, 2] # print("part_2")
		if (identical (res, character(0))) {
			res = paste("no suggestions for", given_txt, sep = " ")
			return(res)
		} else {
			if (length (res) < 6) {
				return(res)
			} else {
				return(head(res))
			}
		}
	}

	trigram_func <- function(given_txt) {
		res = trigram[trigram$word1 == given_txt[1] & trigram$word2 == given_txt[2], 3];
		res_bi = bigram_func(given_txt[2]);
		if (identical (res, character(0))) {
			return (res_bi);
		} else {
			if (length (res) < 6 & identical (res_bi, paste ("no suggestions for", given_txt[2], sep = " ")) == FALSE) {
				res <- c (res, res_bi);
			}
			return(head(res));
		}
	}

	quadgram_func <- function(given_txt) {
		res = quadgram[quadgram$word1 == given_txt[1] & quadgram$word2 == given_txt[2] & quadgram$word3 == given_txt[3], 4];
		res_tri = trigram_func (tail (given_txt, 2))
		if (identical (res, character(0))) {
			return (res_tri);
		} else {
			if (length (res) < 6 & identical (res_tri, paste ("no suggestions for", given_txt[3], sep = " ")) == FALSE) {
				res <- c (res, res_tri);
			}
			return (res);
		}
	}

	output$suggestion <- renderText ({
		given = trimws(input$inp_txt);
		if (identical (given, "")) {
			return("Try typing in something !");
		}
		given = strsplit (stripWhitespace (removeNumbers (removePunctuation (tolower (given), preserve_intra_word_dashes = TRUE))), split = " ")[[1]];
		n = length (given);

		if (n == 1) {
			return (bigram_func (given));
		} else if (n == 2) {
			return (trigram_func (given));
		} else {
			return (quadgram_func (given));
		}
	})
})