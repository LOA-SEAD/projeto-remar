package br.ufscar.sead.loa.remar.statistics

@Singleton
class StatisticFactory {

    ChallengeStats createStatistics(String challengeType) {

        ChallengeStats stats

        switch (challengeType) {
            case 'questionAndAnswer':
                stats = new QuestionAndAnswer()
                break
            case 'multipleChoice':
                stats = new MultipleChoice()
                break
            case 'puzzleWithTime':
                stats = new PuzzleWithTime()
                break
            case 'shuffleWord':
                stats = new ShuffleWord()
                break
            case 'dragPictures':
                stats = new DragPictures()
                break
        }

        return stats
    }
}