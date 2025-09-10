package conn.servlet;
import java.util.*;
import java.sql.*;

public class Eventconfig {
    private Timestamp registrationDeadline;
    private Timestamp submissionDeadline;
    private Timestamp resultsDeclaration;
    private String eventStatus;

    // Getters and Setters
    public Timestamp getRegistrationDeadline() {
        return registrationDeadline;
    }
    public void setRegistrationDeadline(Timestamp registrationDeadline) {
        this.registrationDeadline = registrationDeadline;
    }

    public Timestamp getSubmissionDeadline() {
        return submissionDeadline;
    }
    public void setSubmissionDeadline(Timestamp submissionDeadline) {
        this.submissionDeadline = submissionDeadline;
    }

    public Timestamp getResultsDeclaration() {
        return resultsDeclaration;
    }
    public void setResultsDeclaration(Timestamp resultsDeclaration) {
        this.resultsDeclaration = resultsDeclaration;
    }

    public String getEventStatus() {
        return eventStatus;
    }
    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
    }
}