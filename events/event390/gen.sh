lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 17.832192192192192 --fixed-mass2 53.80304304304305 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004035235.5686674 \
--gps-end-time 1004042435.5686674 \
--d-distr volume \
--min-distance 1599.031581299755e3 --max-distance 1599.051581299755e3 \
--l-distr fixed --longitude 29.091182708740234 --latitude -14.869765281677246 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
