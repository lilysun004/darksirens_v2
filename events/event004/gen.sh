lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.823663663663663 --fixed-mass2 80.6130930930931 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1018448865.0846304 \
--gps-end-time 1018456065.0846304 \
--d-distr volume \
--min-distance 980.5829566038768e3 --max-distance 980.6029566038768e3 \
--l-distr fixed --longitude -56.712432861328125 --latitude -15.607089042663574 --i-distr uniform \
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
